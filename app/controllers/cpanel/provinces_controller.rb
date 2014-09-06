# coding: utf-8
class Cpanel::ProvincesController < Cpanel::ApplicationController
  def index
    @provinces = Province.order("created_at desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @province = Province.find(params[:id])
  end
  
  def new
    @province = Province.new
  end
  
  def create
    @province = Province.new(params[:province])
    if @province.save
      redirect_to cpanle_provinces_path, :notice => "Province Created."
    else
      render :new
    end
  end
  
  def edit
    @province = Province.find(params[:id])
  end
  
  def update
    @province = Province.find(params[:id])
    if @province.update_attributes(params[:province])
      redirect_to cpanel_provinces_url, :notice => "Province Updated."
    else
      render :edit
    end
  end
  
end