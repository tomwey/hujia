# coding: utf-8
class CitiesController < ApplicationController
  
  def province
    province = Province.find_by_code(params[:province_id])
    @cities = []
    if province
      @cities = province.cities
    end
  end
  
end