class HomeController < ApplicationController
  def index
    @coaches = Coach.needed_fields.includes(:coupons, :comments).hot.limit(5)
    @colleges = College.joins(:city).where("cities.code = ?", "511300").sorted
    @banners = Banner.visibled.sorted.limit(4)
  end
  
  def error_404
    render_404
  end
end