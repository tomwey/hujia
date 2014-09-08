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
      # if params[:coach][:image].present?
      #   render :crop
      # else
        redirect_to cpanel_coaches_path, notice: "Create Successfully."
      # end
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
      # if params[:coach][:image].present?
      #   render :crop
      # else
        redirect_to cpanel_coaches_path, notice: "Updated Successfully."
      # end
    else
      render :edit
    end
  end
  
  def destroy
    @coach = Coach.find(params[:id])
    if @coach.destroy
      render :text => "1"
    else
      render :text => "-1"
    end
    # redirect_to cpanel_coaches_url
  end
  
end
