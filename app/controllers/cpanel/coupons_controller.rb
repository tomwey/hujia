# coding: utf-8
class Cpanel::CouponsController < Cpanel::ApplicationController
  def index
    @coupons = Coupon.order("created_at desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @coupon = Coupon.find(params[:id])
  end
  
  def new
    @coupon = Coupon.new
  end
  
  def get_ownerable_id
    
  end
  
  def create
    @coupon = Coupon.new(params[:coupon])
    if @coupon.save
      redirect_to [:cpanel, @coupon], :notice => "Coupon Created."
    else
      render :new
    end
  end
  
  def edit
    @coupon = Coupon.find(params[:id])
  end
  
  def update
    @coupon = Coupon.find(params[:id])
    if @coupon.update_attributes(params[:coupon])
      redirect_to cpanel_coupons_url, :notice => "Coupon Updated."
    else
      render :edit
    end
  end
  
  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy
    redirect_to cpanel_coupons_url
  end
end