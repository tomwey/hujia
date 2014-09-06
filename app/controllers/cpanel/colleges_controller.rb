# coding: utf-8
class Cpanel::CollegesController < Cpanel::ApplicationController
  def index
    @colleges = College.order("created_at desc").paginate per_page: 30, page: params[:page]
  end
  
  def show
    @college = College.find(params[:id])
  end
  
  def new
    @college = College.new
  end
  
  def create
    @college = College.new(params[:college])
    if @college.save
      redirect_to cpanel_colleges_path, :notice => "College Created."
    else
      render :new
    end
  end
  
  def edit
    @college = College.find(params[:id])
  end
  
  def update
    @college = College.find(params[:id])
    if @college.update_attributes(params[:college])
      redirect_to cpanel_colleges_url, :notice => "College Updated."
    else
      render :edit
    end
  end
  
end