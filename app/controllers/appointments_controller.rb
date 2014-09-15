# coding: utf-8
class AppointmentsController < ApplicationController
  before_filter :require_user
  before_filter :find_appointable, only: [:create]
  
  def index
    @appointments = current_user.appointments.includes(:appointable).order('created_at desc')
    
    # @coupons = @appointments.map(&:coupon)
    
  end
  
  def create
    
    appoint = Appointment.where(:appointable_id => @item.id, :appointable_type => @item.class,:user_id => current_user.id).first
    if appoint
      redirect_to appointments_user_path(current_user.nickname), alert: "您之前已经预约报名了该教练。"
      return
    end
    
    if current_user.appoint(@item)
      redirect_to appointments_user_path(current_user.nickname), notice: "预约报名成功。"
    else
      return
    end
  end
  
  def destroy
    @appoint = current_user.appointments.where( :id => params[:id] ).first
    
    return false if @appoint.coupon.blank?
    
    if @appoint.coupon.vouched_by_user?(current_user)
      redirect_to appoints_user_path(current_user.nickname), alert: "领取了的代金券不能被删除。"
      return
    end
    
    if @appoint.destroy
      vouching = Vouching.where(:user_id => current_user.id, :coupon_id => @appoint.coupon.id ).first
      if vouching
        vouching.destroy
      end
      render :text => "1"
    else
      render :text => "-1"
    end
  end
  
  private
  def find_appointable
    
    return false if params[:item].blank?
    
    type,id = params[:item].split(",")
    
    klass = eval(type)
    @item = klass.find_by_id(id)
    if @item.blank?
      return false
    end
    
  end
  
end