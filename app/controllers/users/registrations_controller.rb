# coding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController
  layout "user_layout", only: [:edit, :update]
    
  
  # protected
  def after_update_path_for(resource)
    edit_user_registration_path
  end
  
  def new
    super
  end
  
  def create
    
    user_type = params[:user][:user_type]
    
    child_class = user_type.camelize.constantize
    
    profile = child_class.new(params[resource_name.to_sym][child_class.to_s.underscore.to_sym])
    
    # 删掉不需要的参数
    sign_up_params.delete(:user_type)
    sign_up_params.delete(child_class.to_s.underscore.to_sym)
    
    build_resource(sign_up_params)
    
    # 设置关联
    resource.profile = profile
    
    if user_type == 'Customer'
      resource.verified = true
    else
      resource.verified = false
    end
    
    valid = resource.valid?
    valid = resource.profile.valid? && valid
    
    # customized code end
    
    if valid && resource.save
      if resource.active_for_authentication?        
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)#redirect_location(resource_name, resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?#:inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      @user_type = user_type
      #respond_with resource#respond_with_navigational(resource) { render_with_scope :new }
      render :new
    end
    
  end
  
  def edit
    @user = current_user
    @user.update_private_token unless @user.private_token
  end
  
  def update
    if params[:by] == 'pwd'
      super
    else
      
      @user = User.find(current_user.id)
      profile = @user.profile
      
      @user.nickname = account_update_params[:nickname]
      
      user_type = params[:user][:user_type]
      if user_type == 'customer'
        profile.is_student = params[:user][:customer][:is_student]
        if profile.is_student
          profile.college = params[:user][:customer][:college]
          profile.province = params[:user][:customer][:province]
          profile.city = params[:user][:customer][:city]
        else
          profile.college = nil
          profile.province = nil
          profile.city = nil
        end
        profile.real_name = params[:user][:customer][:real_name]
        profile.mobile = params[:user][:customer][:mobile]
        profile.qq = params[:user][:customer][:qq]
      end
            
      if @user.save && profile.save#(:validate => false)#&& profile.update_attributes(account_update_params[user_type.to_sym])
        if is_flashing_format?
          prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
                  :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        sign_in resource_name, resource, bypass: true
        respond_with resource, location: after_update_path_for(resource)
      else
        render :edit
      end
      
    end
  end
  
end