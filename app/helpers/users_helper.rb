# coding: utf-8
module UsersHelper
  def render_signup_legend(utype)
    if utype == 'customer'
      "注册新用户"
    elsif utype == 'coach'
      "注册教练"
    elsif utype == 'school'
      "注册驾校"
    else
      ""
    end
  end
  
  def render_user_profile_link
    
    css_name = if Vouching.where('user_id = ? and status < 1', current_user.id).count > 0
      "notification"
    else
      ""
    end
    
    span = content_tag :span, "", id: "notification", class: css_name
    html = <<-HTML
    <a href="#{user_path(current_user.nickname)}">我的U驾#{span}</a>
    HTML
    
    html.html_safe
  end
  
  def render_user_role(user)
    if user.profile_type == 'Customer'
      "用户"
    elsif user.profile_type == 'Coach'
      "教练"
    elsif user.profile_type == 'School'
      "驾校"
    else
      ""
    end
  end
  
  def render_user_name(user)
    return '' if user.blank?
    return '' if user.profile.blank?
    
    user.nickname
    # return user.nickname if user.profile.real_name.blank?
    # 
    # user.profile.real_name
  end
  
  def render_user_college(user)
    return '' if user.blank?
    return '' if user.profile.blank?
    
    user.profile.college
  end
  
end
