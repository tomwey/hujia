# coding: utf-8
module CommentsHelper
  def commentable_tag(ownerable)
    if ownerable.class == 'Coach'
      link_to '去评价', comments_coach_path(ownerable), :class => "btn btn-primary"
    else
      link_to '去评价', comments_school_path(ownerable), :class => "btn btn-primary"
    end
  end
  
  def render_all_ratings(comment)
    overall = "总体评价：".html_safe + render_star_tag(comment, 'overall_rating', false) + "<br>".html_safe
    attitude = '<span style="padding-left: 26px">态度：</span>'.html_safe + render_star_tag(comment, 'attitude_rating', false) + "<br>".html_safe
    service = '<span style="padding-left: 26px">服务：</span>'.html_safe + render_star_tag(comment, 'service_rating', false) + "<br>".html_safe
    env = '<span style="padding-left: 26px">环境：</span>'.html_safe + render_star_tag(comment, 'env_rating', false)
    
    (overall + attitude + service + env)
  end
  
  def render_star_tag(comment, type, editable = true)
    star_count = comment[type.to_sym].to_f
    count = star_count.round
    if count > star_count
      full_max_index = count - 1
      half_max_index = count
      empty_min_index = count + 1
    else
      full_max_index = count
      half_max_index = -1
      empty_min_index = count + 1
    end
    
    # puts count
    
    html = ''
    for i in 0...5 do
      image_name = if i < full_max_index
        'icon_star_2.gif'
      elsif half_max_index != -1 and i == half_max_index - 1
        'icon_star_3.gif'
      elsif i >= empty_min_index - 1
        'icon_star_1.gif'
      end
      image = image_tag image_name, :alt => 'star'
      if editable
        html += link_to image, '#', 'data-id' => i, 'data-type' => type, :id => "#{type}_star_#{i}"#, :onclick => 'doVote(this);'
      else
        html += image
      end
      
    end
    
    html.html_safe
  end
end