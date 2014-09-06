class CouponsController < ApplicationController
  before_filter :authorize_user, only: [:user_index]
   
  def user_index
    @coupon = Coupon.find(params[:id])
    @coupon.user_id = params[:user_id].to_i
    @coupon.claimed_at = Time.now
    if @coupon.save
      @coupon.add_visit
      ActiveCode.create!( :coupon_id => @coupon.id )
      render :text => "1"
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