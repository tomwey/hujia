# coding: utf-8
class Cpanel::BannersController < Cpanel::ApplicationController
  def index
    @banners = Banner.where(:visible => true).order("sort desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @banner = Banner.find(params[:id])
  end
  
  def new
    @banner = Banner.new
  end
  
  def create
    @banner = Banner.new(params[:banner])
    if @banner.save
      redirect_to [:cpanel, @banner], :notice => "Ads Created."
    else
      render :new
    end
  end
  
  def edit
    @banner = Banner.find(params[:id])
  end
  
  def update
    @banner = Banner.find(params[:id])
    if @banner.update_attributes(params[:banner])
      redirect_to [:cpanel, @banner], :notice => "Ads Updated."
    else
      render :edit
    end
  end
  
  def destroy
    @banner = Banner.find(params[:id])
    @banner.visible = false
    @banner.save!
    redirect_to cpanel_banners_url
  end
  
  
end
