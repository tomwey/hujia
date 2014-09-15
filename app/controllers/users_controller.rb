# coding: utf-8
class UsersController < ApplicationController
  before_filter :require_user
  before_filter :find_user, :except => [:update_private_token, :bind]
  
  layout 'user_layout', :except => [:update_private_token]
  
  def update_private_token
    current_user.update_private_token
    render :text => current_user.private_token
  end
  
  def show
    self.coupons
    
    set_seo_meta("我的U驾")
    
    render :coupons
    
  end
  
  def appointments
    # @appointments ||= @user.appointments.recent.paginate(:page => params[:page], :per_page => 30)
    @appointments = current_user.appointments.includes(:appointable).order('created_at desc')
    # @appointables = @appointments.collect { |appoint| appoint.appointable }
    
    # @appointments = []
    # appointments.each do |appoint|
    #   if appoint.coupon and (not appoint.coupon.vouched_by_user?(current_user))
    #     @appointments << appoint
    #   end
    # end
    
    set_seo_meta("我的预约报名")
    
  end
  
  def coupons
    # @vouchings = Vouching.where("user_id = ?", current_user.id).includes(:coupon).order('created_at desc').paginate(page: params[:page], per_page: 30)
    @vouchings = current_user.vouchings.includes(:coupon).order('created_at desc').paginate(page: params[:page], per_page: 30)
    
    set_seo_meta("我的代金券")
  end
  
  def actived_coupons
    @codes = ActiveCode.where('user_id = ? and actived_at is not null', @user.id)
    @coupons = Coupon.where(:id => @codes.collect { |c| c.coupon_id }).includes(:ownerable)
  end
  
  def comments
    @comments = @user.comments.visibled.order('created_at desc')
    @commentables = @comments.collect { |comment| comment.commentable }
    
    set_seo_meta("我的评价")
  end
  
  def uncomments    
    # @codes = ActiveCode.where('user_id = ? and actived_at is not null', @user.id)
    
    status = 1
    if not can_send_sms
      status = 0
    end
    
    @vouchings = current_user.vouchings.includes(:coupon).where('status = ?', status)
    puts @vouchings.count
    if @vouchings.count == 1
      @comment = Comment.new
      @coupon = @vouchings.first.coupon
      @comment.commentable = @coupon.ownerable
    end
    
    set_seo_meta("去评价")
  end
  
  def bind
    @profile = current_user.profile
    
    @profile.real_name = params[:name]
    @profile.mobile = params[:mobile]
    @success = @profile.save
  end
  
  def active_code
    @code = ActiveCode.new
  end
  
  def active
    @code = ActiveCode.find_by_code(params[:active_code][:code])
    @code.user_id = params[:active_code][:user_id].to_i
    @code.actived_at = Time.now
    @code.save!
    @code.coupon.active
    redirect_to active_code_user_path, :notice => "验证成功。"
  end
  
  protected
  def find_user
    @user = User.where(:nickname => params[:id]).first
    render_404 if @user.nil?
  end
  
end
