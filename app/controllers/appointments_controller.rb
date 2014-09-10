# coding: utf-8
class AppointmentsController < ApplicationController
  before_filter :require_user
  before_filter :find_appointable, only: [:create]
  
  def index
    @appointments = current_user.appointments.includes(:appointable).order('created_at desc')
    
    # @coupons = @appointments.map(&:coupon)
    
  end
  
  def create
    if current_user.appoint(@item)
      redirect_to appointments_path, notice: "报名成功。"
    else
      return
    end
  end
  
  def destroy
    @appoint = current_user.appointments.where( :id => params[:id] ).first
    if @appoint.destroy
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