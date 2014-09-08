# coding: utf-8
class CoachesController < ApplicationController

  def index
    @coaches = Coach.includes(:coupons, :comments).order('created_at desc').paginate page: params[:page], per_page: 5
  end
  
  def show
    @coach = Coach.find(params[:id])
  end
  
  
  def comments
    @coach = Coach.find_by_id(params[:id])
  end
  
  def college
    @college = College.find_by_id(params[:college_id])
    
  end
  
end