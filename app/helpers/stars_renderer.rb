class StarsRenderer
  def initialize(rating, template)
    @rating = rating
    @template = template
  end
  
  def render_stars
    # puts star_images
    content_tag :div, star_images.html_safe, :class => 'stars'
  end
  
  private
  def star_images
    (0...5).map do |position|
      star_image( ( (@rating - position) * 2 ).round )
    end.join
  end
  
  def star_image(value)
    image_tag "#{star_type(value)}_star.gif", :size => "12x11"
  end
  
  def star_type(value)
    if value <= 0
      'empty'
    elsif value == 1
      'half'
    else
      'full'
    end
  end
  
  def method_missing(*args, &block)
    @template.send(*args, &block)
  end
  
end