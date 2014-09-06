# coding: utf-8
class CollegesController < ApplicationController
  
  def city
    city = City.find_by_code(params[:city_id])
    @type = params[:type]
    @select_colleges = params[:college_ids].split(',') if params[:college_ids]
    @colleges = []
    if city
      @colleges = city.colleges
    end
  end
  
end