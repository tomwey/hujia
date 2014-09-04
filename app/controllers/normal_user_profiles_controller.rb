# coding: utf-8
class NormalUserProfilesController < ApplicationController
  def new 
    @account = NormalUserProfile.new
    @account.build_user
  end
  
  def create
    @account = NormalUserProfile.new(params[:normal_user_profile])
    if @account.save
      redirect_to root_path, :notice => "注册成功"
    else
      render :new
    end
  end
  
end