# coding: utf-8
module CommentsHelper
  def commentable_tag(ownerable)
    if ownerable.class == 'Coach'
      link_to '去评价', comments_coach_path(ownerable), :class => "btn btn-primary"
    else
      link_to '去评价', comments_school_path(ownerable), :class => "btn btn-primary"
    end
  end
  
  def render_commentable_avatar(commentable, opts = {})
    return '' if commentable.blank?
    
    link = opts[:link] || true
    img = image_tag commentable.image.thumb, style: "width:87px; height:50px"
    
    if link
      link_to img, commentable
    else
      img
    end
    
  end
  
  # 显示某个可以评论的对象的所有评论
  def render_comments_for_owner(ownerable)
    return '' if ownerable.blank?
    return '' if ownerable.comments.empty?
    
    comments_li = render "/comments/comment", collection: ownerable.comments
    content_tag :ul, comments_li.html_safe, class: "evaluation"
  end
  
  def render_all_ratings(comment)
    overall = "总体评价：".html_safe + render_star_tag(comment, 'overall_rating', false) + "<br>".html_safe
    attitude = '<span style="padding-left: 26px">态度：</span>'.html_safe + render_star_tag(comment, 'attitude_rating', false) + "<br>".html_safe
    service = '<span style="padding-left: 26px">服务：</span>'.html_safe + render_star_tag(comment, 'service_rating', false) + "<br>".html_safe
    env = '<span style="padding-left: 26px">环境：</span>'.html_safe + render_star_tag(comment, 'env_rating', false)
    
    (overall + attitude + service + env)
  end
  
  # 获取总评价的分数
  def render_comment_avarge_score(commentable)
    if commentable.comments_count == 0
      return (commentable.star_count.to_f)
    end
    
    comments = commentable.comments
    avg_sum = 0
    comments.each do |c|
      avg_sum += c.avarge_rating
    end
    
    (commentable.star_count + (avg_sum / commentable.comments_count.to_f)) / 2.0
    
  end
  
  # 获取总评价的百分比
  def render_star_percent(commentable)
    score = render_comment_avarge_score(commentable)
    ( score.to_f / 5.0 ) * 100
  end
  
  # 获取某一种评价的分数, 例如: 4.5
  def render_comment_score_for(commentable, type)
    return 0 if commentable.blank?
    return 0 if commentable.comments.empty?
    
    sum = 0
    commentable.comments.each do |comment|
      sum += comment[type]
    end
    
    sum.to_f / commentable.comments_count
    
  end
  
  def render_comment_status(comment)
    return '' if comment.blank?
    avarge = (comment.overall_rating + comment.attitude_rating + comment.service_rating + comment.env_rating) / 4.0
    
    status = if avarge >= 4.0
      "很满意"
    elsif avarge >= 3.5
      "满意"
    elsif avarge >= 3.0
      "合格"
    else
      "很差"
    end
    
    status
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
        'full_star.gif'
      elsif half_max_index != -1 and i == half_max_index - 1
        'empty_star.gif'
      elsif i >= empty_min_index - 1
        'empty_star.gif'
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