# coding: utf-8
module CoachesHelper
  
  def render_coach_service_type(coach)
    coach.service_type
  end
  
  def render_coach_info(coach)
    if coach.blank?
      return ''
    end
    link_to "【#{coach.company}】#{coach.real_name}", coach
  end
  
  def render_star_percent(commentable)
    
    if commentable.comments_count == 0
      return (commentable.star_count / 5.0) * 100
    end
    
    comments = commentable.comments
    avg_sum = 0
    comments.each do |c|
      avg_sum += c.avarge_rating
    end
    
    ( (commentable.star_count + (avg_sum / commentable.comments_count.to_f)) / 2.0 ) * 100
    
    
  end
  
  def render_coupon_info(coach)
    coupon = coach.coupons.first
    if coupon.blank?
      return ""
    end
    
    html = <<-HTML
    <p class="hyj tr">会员价<span class="special">￥#{(coach.price - coupon.value.to_i)}</span>
    </p>
    HTML
    
    html.html_safe
    
  end
  
  def render_coupon_count(coach)
    "#{coach.coupons.first.claims_count}人购买" if coach.coupons.first
  end
  
  def render_coach_icon(coach, size = :normal, opts = {})
    
    if coach.blank? or coach.image.blank?
      return ""
    end
    
    width = coach_icon_width_for_size(size)
    height = coach_icon_height_for_size(size)
    
    img = image_tag(coach.image.url(size), alt: coach.real_name , :style => "width:#{width}px;height:#{height}px;")
    
    link = opts[:link] || true
    
    url = opts[:url] || coach_path(coach)

    if link
      raw %(<a href="#{url}" title="#{coach.real_name}" class="block">#{img}</a>)
    else
      raw img
    end
    
  end
  
  def coach_icon_width_for_size(size)
    case size
    when :normal then 48
    when :small then 24
    when :large then 300
    when :big then 120
    when :thumb then 160
    else size
    end
  end
  
  def coach_icon_height_for_size(size)
    case size
    when :normal then 80
    when :small then 40
    when :large then 96
    when :big then 150
    when :thumb then 160
    else size
    end
  end
  
end