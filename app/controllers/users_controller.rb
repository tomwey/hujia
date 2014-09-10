# coding: utf-8
class UsersController < ApplicationController
  before_filter :require_user
  before_filter :find_user, :except => [:update_private_token, :bind]
  
  layout 'user_layout', :except => [:update_private_token]
  
  def update_private_token
    current_user.update_private_token
    render :text => current_user.private_token
  end
  
  def show
    self.appointments
    render :appointments
  end
  
  def appointments
    @appointments ||= @user.appointments.recent.paginate(:page => params[:page], :per_page => 30)
  end
  
  def coupons
    @coupons = @user.coupons.order('claimed_at desc').paginate(:page => params[:page], :per_page => 30)
  end
  
  def actived_coupons
    @codes = ActiveCode.where('user_id = ? and actived_at is not null', @user.id)
    @coupons = Coupon.where(:id => @codes.collect { |c| c.coupon_id }).includes(:ownerable)
  end
  
  def comments
    @comments = @user.comments.visibled.order('created_at desc')
    @commentables = @comments.collect { |comment| comment.commentable }
  end
  
  def uncomments    
    @codes = ActiveCode.where('user_id = ? and actived_at is not null', @user.id)
    @coupons = Coupon.where(:id => @codes.collect { |c| c.coupon_id })
  end
  
  def bind
    @profile = current_user.profile
    
    @profile.real_name = params[:name]
    @profile.mobile = params[:mobile]
    @success = @profile.save
    
  end
  
  def active_code
    @code = ActiveCode.new
  end
  
  def active
    @code = ActiveCode.find_by_code(params[:active_code][:code])
    @code.user_id = params[:active_code][:user_id].to_i
    @code.actived_at = Time.now
    @code.save!
    @code.coupon.active
    redirect_to active_code_user_path, :notice => "验证成功。"
  end
  
  protected
  def find_user
    @user = User.where(:nickname => params[:id]).first
    render_404 if @user.nil?
  end
  
end
