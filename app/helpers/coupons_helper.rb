# coding: utf-8
module CouponsHelper
  
  def get_coupon_tag(coupon)
    return '' if current_user.blank?
    return '' if coupon.blank?
    
    if coupon.vouched_by_user?(current_user)
      return "已领取"
    end
    
    if current_user.profile.blank? or current_user.profile.mobile.blank?
      link_to "领取", "#login", 'data-toggle' => "modal", class: "voucher-btn", 'data-url' => coupon_vouchings_path(coupon)
    else
      link_to "领取", coupon_vouchings_path(coupon), class: "voucher-btn", method: :post
    end
  end
  
  def render_owner(coupon)
    if coupon.ownerable_type == 'School'
      return "[驾校] #{coupon.ownerable.name}"
    else
      return "[教练] #{coupon.ownerable.real_name}"
    end
  end
  
  def render_coupon_info(ownerable)
    
    return '' if ownerable.blank?
    
    coupon = ownerable.coupons.first
    if coupon.blank?
      return ""
    end
    
    return '' if ownerable.price.blank?
    return '' if coupon.value.blank?
    
    html = <<-HTML
    <p class="hyj tr">会员价<span class="special">￥#{(ownerable.price - coupon.value.to_i)}</span>
    </p>
    HTML
    
    html.html_safe
    
  end
  
  def render_coupon_ownerable_avatar(coupon)
    return '' if coupon.blank?
    return '' if coupon.ownerable.blank?
    
    image_tag  coupon.ownerable.image.thumb
  end
  
  def render_coupon_count(ownerable)
    "#{ownerable.coupons.first.claims_count}人购买" if ownerable.coupons.first
  end
  
  def render_coupon_status(coupon)
    code = ActiveCode.where('coupon_id = ? and user_id = ? ', coupon.id, coupon.user.id).first
    if code && code.actived_at
      content_tag :span, "已验证", :class => "label label-success"
    else
      content_tag :span, "未验证", :class => "label"
    end
  end
  
  def render_coupon_title(ownerable)
    return ownerable.coupons.first.title if ownerable.coupons.first
    return ''
  end
  
  def render_coupon_actived(ownerable)
    ownerable.coupons.first.actives_count if ownerable.coupons.first
  end
  
  def render_coupon_left(ownerable)
    return ownerable.coupons.first.publish_count - ownerable.coupons.first.actives_count if ownerable.coupons.first
    return false
  end
  
  def render_coupon_value(ownerable)
    return ownerable.coupons.first.value if ownerable.coupons.first
    return 0
  end
  
  def render_coupon_price(ownerable)
    return (ownerable.price - ownerable.coupons.first.value) if ownerable.coupons.first
    return ownerable.price
  end
  
end