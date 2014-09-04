# coding: utf-8
class Cpanel::SchoolsController < Cpanel::ApplicationController
  
  def index
    @schools = School.order('created_at DESC').paginate :page => params[:page], :per_page => 30
  end
  
  def show
    @school = School.find(params[:id])
    @user = @school.user
  end
  
  def new
    @school = School.new
    @school.user = User.new
    
    # @school.coupons.build
  end
  
  def create
    @user = User.new(params[:school][:user])
    
    params[:school].delete(:user)
    
    @school = School.new(params[:school])
    @school.user = @user
    
    valid = @user.valid?
    valid = @school.valid? && valid
    
    if valid && @school.save
      redirect_to cpanel_schools_path, notice: "Create Successfully."
    else
      render :new
    end
  end
  
  def edit
    @school = School.find(params[:id])
  end
  
  def update
    @school = School.find(params[:id])
    if @school.update_attributes(params[:school])
      redirect_to cpanel_schools_path, notice: "Updated Successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @school = School.find(params[:id])
    @school.destroy
    redirect_to cpanel_schools_url
  end
  
end
