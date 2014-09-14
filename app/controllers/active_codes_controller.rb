# coding: utf-8
class ActiveCodesController < ApplicationController
  before_filter :require_user
  
  layout "user_layout"
  
  def new
    @coupon = Coupon.find(params[:coupon_id])
    @active_code = @coupon.active_codes.build
  end
  
  def create
    
    @coupon = Coupon.find(params[:active_code][:coupon_id])
    @code = ActiveCode.where(:user_id => current_user.id, :coupon_id => @coupon.id, :code => params[:active_code][:code]).first
    
    if @code.blank?
      redirect_to active_coupon_path(@coupon), alert: "验证码不正确"
      return
    end
    
    unless @code.verified
      redirect_to active_coupon_path(@coupon), alert: "验证码已使用"
      return
    end
    
    @code.actived_at = Time.now
    @code.verified = false
    
    if @code.save
      vouching = Vouching.where(:user_id => current_user.id, :coupon_id => @coupon.id).first
      if vouching
        vouching.status = 1 # 已验证
        vouching.save
      end
      @code.coupon.active
      redirect_to new_comment_path(:coupon_id => @coupon.id), notice: "验证成功"#coupons_user_path(current_user.nickname), notice: "验证成功"
    else
      redirect_to active_coupon_path(@coupon), alert: "验证失败"
    end
    
  end
  
  def destroy
    
  end
end