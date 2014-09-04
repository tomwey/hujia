class HomeController < ApplicationController
  def index
    @schools = School.order('created_at desc').limit(3)
    @coaches = Coach.order('created_at desc').limit(3)
    
    @pages = Page.recent.limit(6)
    
    @sugests = []
    
    @sugests << @schools[0]
    @sugests << @coaches[0]
  end
end