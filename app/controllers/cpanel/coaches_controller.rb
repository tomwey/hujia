# coding: utf-8
class Cpanel::CoachesController < Cpanel::ApplicationController
  
  def index
    @coaches = Coach.order('created_at DESC').paginate :page => params[:page], :per_page => 30
  end
  
  def show
    @coach = Coach.find(params[:id])
    @user = @coach.user
  end
  
  def new
    @coach = Coach.new
    @coach.user = User.new
  end
  
  def create
    @user = User.new(params[:coach][:user])
    
    params[:coach].delete(:user)
    
    @coach = Coach.new(params[:coach])
    @coach.user = @user
    
    valid = @user.valid?
    valid = @coach.valid? && valid
    
    if valid && @coach.save
      redirect_to cpanel_coaches_path, notice: "Create Successfully."
    else
      render :new
    end
  end
  
  def edit
    @coach = Coach.find(params[:id])
  end
  
  def update
    @coach = Coach.find(params[:id])
    params[:coach][:service_area_ids] ||= []
    if @coach.update_attributes(params[:coach])
      redirect_to cpanel_coaches_path, notice: "Updated Successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @coach = Coach.find(params[:id])
    @coach.destroy
    redirect_to cpanel_coaches_url
  end
  
end
