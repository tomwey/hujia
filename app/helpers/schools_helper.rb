# coding: utf-8
module SchoolsHelper
  def render_school_icon(school, size = :normal, opts = {})
    
    if school.blank? or school.image.blank?
      return ""
    end
    
    width = school_icon_width_for_size(size)
    height = school_icon_height_for_size(size)
    
    img = image_tag(school.image.url(size), :style => "width:#{width}px;height:#{height}")
    
    link = opts[:link] || true
    
    if link
      raw %(<a href="#{cpanel_school_path(school)}">#{img}</a>)
    else
      raw img
    end
    
  end
  
  def school_icon_width_for_size(size)
    case size
    when :normal then 48
    when :small then 24
    when :large then 64
    when :big then 120
    else size
    end
  end
  
  def school_icon_height_for_size(size)
    case size
    when :normal then 80
    when :small then 40
    when :large then 96
    when :big then 150
    else size
    end
  end
  
end