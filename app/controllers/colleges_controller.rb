# coding: utf-8
class CollegesController < ApplicationController
  
  def city
    city = City.find_by_code(params[:city_id])
    @colleges = []
    if city
      @colleges = city.colleges
    end
  end
  
end