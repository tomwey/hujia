# coding: utf-8
class VouchingsController < ApplicationController
  before_filter :require_user
  
  def create
        
    count = Vouching.where(:user_id => current_user.id).count
    limit_count = SiteConfig.vouch_limit_count.blank? ? 2 : SiteConfig.vouch_limit_count.to_i
    if count >= limit_count
      redirect_to appointments_url, :alert => "一个用户最多只能领取2个代金券"
      return
    end
    
    vouching = Vouching.where(:user_id => current_user.id, :coupon_id => params[:coupon_id]).first
    if vouching
      redirect_to appointments_url, :notice => "您已经领过了该代金券"
      return
    end
    
    @coupon = Coupon.find(params[:coupon_id])
    if Vouching.create(:user_id => current_user.id, :coupon_id => @coupon.id)
      @coupon.add_visit
      ActiveCode.create!( :coupon_id => @coupon.id )
      render :active
    else
      redirect_to appointments_url, :alert => "领取失败!"
    end
    
  end
  
end