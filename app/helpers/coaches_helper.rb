# coding: utf-8
module CoachesHelper
  
  def render_coach_service_type(coach)
    coach.service_type
  end
  
  def render_coach_info(coach)
    "【#{coach.company}】#{coach.real_name}"
  end
  
  def render_coach_icon(coach, size = :normal, opts = {})
    
    if coach.blank? or coach.image.blank?
      return ""
    end
    
    width = coach_icon_width_for_size(size)
    height = coach_icon_height_for_size(size)
    
    img = image_tag(coach.image.url(size), :style => "width:#{width}px;height:#{height}")
    
    link = opts[:link] || true
    
    if link
      raw %(<a href="#{cpanel_coach_path(coach)}">#{img}</a>)
    else
      raw img
    end
    
  end
  
  def coach_icon_width_for_size(size)
    case size
    when :normal then 48
    when :small then 24
    when :large then 64
    when :big then 120
    else size
    end
  end
  
  def coach_icon_height_for_size(size)
    case size
    when :normal then 80
    when :small then 40
    when :large then 96
    when :big then 150
    else size
    end
  end
  
end