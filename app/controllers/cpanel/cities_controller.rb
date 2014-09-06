# coding: utf-8
class Cpanel::CitiesController < Cpanel::ApplicationController
  def index
    @cities = City.order("created_at desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @city = City.find(params[:id])
  end
  
  def new
    @city = City.new
  end
  
  def create
    @city = City.new(params[:city])
    if @city.save
      redirect_to cpanle_cities_path, :notice => "City Created."
    else
      render :new
    end
  end
  
  def edit
    @city = City.find(params[:id])
  end
  
  def update
    @city = City.find(params[:id])
    if @city.update_attributes(params[:city])
      redirect_to cpanel_cities_url, :notice => "City Updated."
    else
      render :edit
    end
  end
  
end