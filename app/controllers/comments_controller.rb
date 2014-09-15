# coding: utf-8
class CommentsController < ApplicationController
  before_filter :require_user
  
  # TODO: before_filter :check_allow_comment, 
  
  layout "user_layout"
  
  def new
    @coupon = Coupon.find_by_id(params[:coupon_id])
    if @coupon.blank?
      render_404
      return
    end
    
    vouching = Vouching.select('status').where(:user_id => current_user.id, :coupon_id => @coupon.id).first
    if vouching.blank?
      redirect_to current_user, alert: "您还未领取该代金券。"
      return
    end
    
    if vouching.status != 1 and can_send_sms
      redirect_to coupons_user_path(current_user.nickname), alert: "您还未验证该代金券。"
      return
    end
    
    @comment = Comment.new
    @comment.commentable = @coupon.ownerable
  end
  
  def create
    @coupon_id = params[:comment][:coupon_id]
    
    params[:comment].delete(:coupon_id)
    
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    
    if @comment.save
      
      # 更新代金券的评论状态
      vouching = Vouching.where(:user_id => current_user.id, coupon_id: @coupon_id).first
      if vouching
        vouching.status = 2
        vouching.save
      end
      
      # 更新平均分的记录
      score = (@comment.overall_rating + @comment.service_rating + @comment.env_rating + @comment.attitude_rating) / 4
      RatingScore.where(:user_id => current_user.id, :comment_id => @comment.commentable_id, :score => score ).first_or_create
      
      # 更新积分
      profile = current_user.profile
      if @comment.is_show_user_info
        profile.score += 15
      else
        profile.score += 5
      end
      profile.save
      
      redirect_to comments_user_path(current_user.nickname), :notice => "评论成功"
    else
      render :new
    end
    
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    
    if @comment.update_attributes(params[:comment])
      redirect_to comments_user_path(current_user.nickname), :notice => "评论修改成功"
    else
      render :edit
    end
  end
  
end