# coding: utf-8
module CoachesHelper
  
  def render_coach_service_type(coach)
    coach.service_type
  end
  
  def render_coach_info(coach)
    if coach.blank?
      return ''
    end
    link_to "【#{coach.company}】#{coach.real_name}", coach, target: "_blank"
  end
  
  def render_service_colleges(ownerable)
    return '' if ownerable.blank?
    return '' if ownerable.service_areas.empty?
    ownerable.service_areas.map(&:name).join(",")
  end
  
  def render_coach_intro_image(coach)
    return '' if coach.blank?
    
    photo = coach.photos.first
    
    return '' if photo.blank?
  
    
    image_tag photo.image.large
    
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
      raw %(<a href="#{url}" target="_blank" title="#{coach.real_name}" class="block">#{img}</a>)
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