class CouponsController < ApplicationController
  def user_index
    @coupon = Coupon.find(params[:id])
    @coupon.user_id = params[:user_id].to_i
    @coupon.claimed_at = Time.now
    if @coupon.save
      ActiveCode.create!( :coupon_id => @coupon.id )
      render :text => "1"
    else
      render :text => "-1"
    end
  end
  
end