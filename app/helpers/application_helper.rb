# coding: utf-8
module ApplicationHelper
  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", class: "close", 'data-dismiss' => "alert") + 
      message, class: "alert alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
  
  def render_page_title
    site_name = SiteConfig.app_name
    title = @page_title ? "#{site_name} - #{@page_title}" : site_name rescue "SITE_NAME"
    content_tag("title", title, nil, false)
  end
  
  def render_user_bar
    if user_signed_in?
      render 'layouts/signed_in_user_bar'
    else
      render 'layouts/signed_out_user_bar'
    end
  end
  
  def link_to_add_fields(name, f, association)
    new_object  = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render("/cpanel/#{association}/form_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "btn")
  end
  
  # 自定义devise错误
  def my_devise_error_messages!
    
    profile = resource.profile
    return "" if profile.nil?
    return "" if resource.errors.empty? && profile.errors.empty?
    
    messages = profile_messages = ""
    
    if !resource.errors.empty?
      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
    
    if !profile.errors.empty?
      profile_messages = profile.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
    
    messages = messages + profile_messages
    
    if messages.blank?
      return ""
    end
    
    html = <<-HTML
    <div class="alert alert-block alert-error">
      <a class="close" data-dismiss='alert' href="#">×</a>
      <p><strong>有 #{resource.errors.count + profile.errors.count} 处问题导致无法提交:</strong></p>
      <ul>#{messages}</ul>
    </div>
    HTML
    
    html.html_safe
    
  end
  
  # 自定义驾校或者教练错误
  def my_custom_error_messages!(target)

    return "" if target.errors.empty? && target.user.errors.empty?
    
    messages = profile_messages = ""
    
    if !target.user.errors.empty?
      messages = target.user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
    
    if !target.errors.empty?
      profile_messages = target.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    end
    
    messages = messages + profile_messages
    
    if messages.blank?
      return ""
    end
    
    html = <<-HTML
    <div class="alert alert-block alert-error">
      <a class="close" data-dismiss='alert' href="#">×</a>
      <p><strong>有 #{target.errors.count + target.user.errors.count} 处问题导致无法提交:</strong></p>
      <ul>#{messages}</ul>
    </div>
    HTML
    
    html.html_safe
  end
  
  def college_checkbox(collection, target)
    return '' if target.blank?
    return '' if collection.empty?
    
    html = ''
    
    collection.each do |item|
      input = content_tag :input, nil, checked: target.service_areas.map(&:id).include?(item[0].to_i), name: "coach[service_area_ids][]", type: "checkbox", value: item[0]
      label = content_tag :label, (input + " #{item[1]}"), class: "checkbox inline"
      html += label
    end
    
    html.html_safe
  end
  
  def options_for_select(collection, target, type)
    return '' if target.blank?
    
    # if target.new_record? and type != :province
    #   return ''
    # end
    
    return '' if collection.empty?
    
    html = ''
  
    collection.each do |item|
      html +=  content_tag :option, item[1], :value => item[0], :selected => item[0] == target[type]
    end
    
    html.html_safe
  end
  
  def filterable(column, title = nil, value = nil, onclick = nil)
    title ||= '全部'
    # value ||= ''
    
    css_name = if value == params[column]
      "select"
    else
      ""
    end
    
    if title == "确定"
      css_name = ""
    end
    
    if onclick
      link_to title, params.merge(column => value), :onclick => onclick
    else
      link_to title, params.merge(column => value), :class => css_name
    end
    
  end
  
  def sort_link(column, title = nil)
    # title ||= column.titleize
    # css_class = column == sort_column ? "active" : nil
    # direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    # 
    # css_class2 = direction == "desc" ? "up" : "down"
    # span = content_tag :span, '',:class => "#{css_class2} arrow"
    # a = link_to title, params.merge(:sort => column, :direction => direction, :page => nil)
    # content_tag :li, (a+span), :class => css_class
    
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    puts direction
    i_html = content_tag :i, nil, class: "sort-icon"
    
    link_to (title + i_html).html_safe, params.merge(:sort => column, :direction => direction, :page => nil)
    
    # link_to title, params.merge(:sort => column, :direction => direction, :page => nil), :class => css_class
  end
  
  def select_conditions
    html = ''
    params.each do |key, value|
      if (key == 'dt' or key == 'st' or key == 'price' or key == 'c') && value.present?
        if key == "price"
          html += link_to "#{render_low_price}-#{render_high_price}", '#', :style => "padding-right:5px;", 'data-key' => key, :onclick => 'App.unselect(this);'
        else
          html += link_to value, '#', :style => "padding-right:5px;", 'data-key' => key, :onclick => 'App.unselect(this);'
        end
      end
    end
    if html.present?
      html += '<br>'
      html = '已选条件：' + html
    end
    html.html_safe
  end
  
  def render_low_price
    if params[:price].blank?
      "3000"
    else
      prices = params[:price].split("-")
      if prices.count == 1
        prices.first.to_i.to_s
      elsif prices.count == 2
        v1 = prices.first.to_i
        v2 = prices.last.to_i
        if v1 > v2
          v2.to_s
        else
          v1.to_s
        end
      else
        "3000"
      end
    end
  end
  
  def render_high_price
    if params[:price].blank?
      "5000"
    else
      prices = params[:price].split("-")
        if prices.count == 1
          ""
        elsif prices.count == 2
          v1 = prices.first.to_i
          v2 = prices.last.to_i
          if v1 > v2
            v1.to_s
          else
            v2.to_s
          end
        else
          "5000"
        end
    end
  end
  
  def render_ownerable_title(ownerable)
    if ownerable.class.to_s == 'Coach'
      "【#{ownerable.company}】#{ownerable.real_name}"
    else
      "#{ownerable.name}"
    end
  end
  
  def render_comment_star(commentable)
    comments = commentable.comments
    
    sum = 0
    # comments.inject{ |sum, c| c.avarge_rating + sum }
    comments.each do |c|
      sum += c.avarge_rating
    end
    
    if commentable.comments_count == 0
      star_count = commentable.star_count
    else
      star_count = (commentable.star_count + (sum / commentable.comments_count.to_f)) / 2.0
    end
    
    StarsRenderer.new(star_count, self).render_stars
  end
  
  # 搜索价格范围
  def price_scopes
    # %w(3500-3699 3700-3899 3900-4099 4100元以上)
    return SiteConfig.price_scope.split(',') if SiteConfig.price_scope
    return []
  end
  
  # 驾照类型
  def drive_types
    return SiteConfig.drive_type.split(',').map { |c| [c, c] } if SiteConfig.drive_type
    return []
  end
  
  # 服务类型
  def service_types
    return SiteConfig.service_type.split(',').map { |c| [c, c] } if SiteConfig.service_type
    return []
  end
  
  # 默认星级
  def default_stars
    return SiteConfig.default_star.split(',').map { |c| [c, c] } if SiteConfig.default_star
    return []
  end
  
end
