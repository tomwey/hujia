# coding: utf-8
module CouponsHelper
  def render_owner(coupon)
    if coupon.ownerable_type == 'School'
      return "[驾校] #{coupon.ownerable.name}"
    else
      return "[教练] #{coupon.ownerable.real_name}"
    end
  end
  
  def render_coupon_status(coupon)
    code = ActiveCode.where('coupon_id = ? and user_id = ? ', coupon.id, coupon.user.id).first
    if code && code.actived_at
      content_tag :span, "已验证", :class => "label label-success"
    else
      content_tag :span, "未验证", :class => "label"
    end
  end
  
end