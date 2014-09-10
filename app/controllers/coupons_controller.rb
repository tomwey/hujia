# coding: utf-8
class CouponsController < ApplicationController
  before_filter :authorize_user, only: [:getted]
  
  # 领取
  def getted
    @coupon = Coupon.find(params[:id])
    @coupon.user_id = params[:user_id].to_i
    # @coupon.claimed_at = Time.now
    if @coupon.save
      @coupon.add_visit
      ActiveCode.create!( :coupon_id => @coupon.id )
      @appointment = Appointment.where(:user_id => current_user.id, 
                                       :appointable_id => @coupon.ownerable.id, 
                                       :appointable_type => @coupon.ownerable.class).first
      @appointment.destroy
      render :active
    else
      render :text => "-1"
    end
  end
  
  private
  def authorize_user
    require_user
    
    current_user.id.to_i == params[:user_id].to_i
  end
  
end