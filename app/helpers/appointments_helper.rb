# coding: utf-8
module AppointmentsHelper
  def render_appointable_name(appointment)
    if appointment.appointable_type == 'School'
      return appointment.appointable.name
    else
      return appointment.appointable.real_name
    end
  end
  
  def render_appointment_coupon_value(appointment)
    if appointment.coupon
      appointment.coupon.value
    else
      ""
    end
  end
  
  def render_appointment_coupon_duration(appointment)
    unless appointment.coupon
      return ""
    end
    "#{appointment.coupon.start_date}至#{appointment.coupon.end_date}"
  end
  
  def render_appointment_coupon_left_count(appointment)
    unless appointment.coupon
      return ""
    end
    
    appointment.coupon.publish_count - appointment.coupon.actives_count
  end
  
  def render_appointment_coupon_status(appointment)
    if appointment.coupon && appointment.coupon.user == @user
      content_tag :span, "已领取", :class => "label label-success"
    else
      link_to '领取', '#', :class => "btn btn-success", 'data-user-id' => @user.id,'data-coupon-id' => appointment.coupon.id, :onclick => "App.getCoupon(this);"
    end
  end
  
  def render_appointable_type(appointment)
    type = if appointment.appointable_type == 'School'
      "驾校"
    else
      "教练"
    end
    
    type
  end
  
  def appointable_tag(appointable)
    return "" if appointable.blank?
    
    
    link = if current_user.blank?
      link_to "免费领取代金券并报名", new_user_session_path, :class => "detail-btn"
    else
      link_to "免费领取代金券并报名", appointments_path(:item => "#{appointable.class},#{appointable.id}"), method: :post,  class: "detail-btn", 'data-type' => appointable.class, 'data-id' => appointable.id, onclick:"App.appointable(this);" 
    end
    
    "#{link} &emsp;".html_safe
    
    # appointed = false
    # 
    # if current_user
    #   if Appointment.where(:appointable_type => appointable.class, :appointable_id => appointable.id, :user_id => current_user.id ).count > 0
    #     appointed = true
    #   end
    # else
    #   return link_to "立即报名", new_user_session_path, :class => "btn btn-primary"
    # end
    # 
    # if appointed
    #   link_to("取消报名", '#', :title => "取消报名",
    #           'data-state' => 'appointed', 'data-type' => appointable.class, 'data-id' => appointable.id, 
    #           :class => "btn btn-danger", :onclick => "return App.appointable(this);")
    # else
    #   link_to("立即报名", '#', :title => "立即报名",
    #           'data-state' => '', 'data-type' => appointable.class, 'data-id' => appointable.id, 
    #           :class => "btn btn-primary", :onclick => "return App.appointable(this);")
    # end
    
  end
  
end