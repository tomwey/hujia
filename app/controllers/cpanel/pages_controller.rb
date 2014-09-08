# coding: utf-8
class Cpanel::PagesController < Cpanel::ApplicationController
  def index
    @pages = Page.order("created_at desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @page = Page.find_by_slug(params[:id])
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    if @page.save
      redirect_to cpanel_pages_path, :notice => "Page Created."
    else
      render :new
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      redirect_to cpanel_pages_url, :notice => "Page Updated."
    else
      render :edit
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to cpanel_pages_url
  end
end