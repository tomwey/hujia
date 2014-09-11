class HomeController < ApplicationController
  def index
    @coaches = Coach.includes(:coupons, :comments).order('created_at desc').limit(5)
    @colleges = College.order('created_at desc')
    @banners = Banner.visibled.sorted.limit(4)
  end
  
  def error_404
    render_404
  end
end