# coding: utf-8
module VouchingsHelper
  def render_vouching_coupon_status(vouching)
    return '' if vouching.blank?
    
    case vouching.status
      when 0 then "已领取"
      when 1 then "已验证"
      when 2 then "已评价"
      else ""
    end
  end
  
  def render_claim_coupon_time(coupon)
    return '' if coupon.blank?
    
    v = Vouching.where(:user_id => current_user.id, :coupon_id => coupon.id).first
    
    return '' if v.blank?
    
    l v.created_at, format: :long
    
  end
  
  def render_vouching_link_tag(vouching)
    return '' if vouching.blank?
    
    return '' if vouching.coupon.blank?
    
    # is_send = SiteConfig.send_sms.split(',')[0]
    
    if vouching.status == 2
      return link_to "查看评价".html_safe, comments_user_path(current_user.nickname), class: "vonBtn"
    end
    
    unless can_send_sms
      return link_to "评&emsp;价".html_safe, new_comment_path(:coupon_id => vouching.coupon.id), class: "vonBtn"
    end
    
    case vouching.status
    when 0 then link_to "验&emsp;证".html_safe, active_coupon_path(vouching.coupon), class: "vonBtn"
    when 1 then link_to "评&emsp;价".html_safe, new_comment_path(:coupon_id => vouching.coupon.id), class: "vonBtn"
    when 2 then link_to "查看评价".html_safe, comments_user_path(current_user.nickname), class: "vonBtn"
    else ""
    end
  end
end