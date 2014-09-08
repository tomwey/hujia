class HomeController < ApplicationController
  def index
    @coaches = Coach.includes(:coupons, :comments).order('created_at desc').limit(5)
    @colleges = College.order('created_at desc')
    @banners = Banner.visibled.sorted.limit(4)
    @pages   = Page.where('slug like ?', "%xyxz%").order('sort asc')
  end
end