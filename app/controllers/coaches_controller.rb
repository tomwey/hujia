# coding: utf-8
class CoachesController < ApplicationController

  def show
    @coach = Coach.find(params[:id])
  end
  
  
  def comments
    @coach = Coach.find_by_id(params[:id])
  end
  
end