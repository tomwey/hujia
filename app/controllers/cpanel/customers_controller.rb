# coding: utf-8
class Cpanel::CustomersController < Cpanel::ApplicationController
  
  def index
    @customers = Customer.order('created_at DESC').paginate :page => params[:page], :per_page => 30
  end
  
  def show
    @customer = Customer.find(params[:id])
    @user = @customer.user
  end
  
  def new
    @customer = Customer.new
    @customer.user = User.new
  end
  
  def create
    @user = User.new(params[:customer][:user])
    
    params[:customer].delete(:user)
    
    @customer = Customer.new(params[:customer])
    @customer.user = @user
    
    valid = @user.valid?
    valid = @customer.valid? && valid
    
    if valid && @customer.save
      redirect_to cpanel_customers_path, notice: "Create Successfully."
    else
      render :new
    end
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      redirect_to cpanel_customers_path, notice: "Updated Successfully."
    else
      render :edit
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to cpanel_customers_url
  end
  
end
