# coding: utf-8
class AppointmentsController < ApplicationController
  before_filter :require_user
  before_filter :find_appointable, except: [:index]
  
  def index
    
  end
  
  def create
    current_user.appoint(@item)
    render :text => "1"
  end
  
  def destroy
    current_user.unappoint(@item)
    render :text => "1"
  end
  
  private
  def find_appointable
    @success = false
    @element_id = "appointable_#{params[:type]}_#{params[:id]}"
    if not params[:type].in?(['School', 'Coach'])
      render :text => "-1"
      return false
    end
    
    klass = eval(params[:type])
    @item = klass.find_by_id(params[:id])
    if @item.blank?
      render :text => "-2"
      return false
    end
    
  end
  
end