# coding: utf-8
class PagesController < ApplicationController
  
  def index
    @pages = Page.recent.limit(6)
  end
  
  def show
    @page = Page.find_by_slug(params[:id])
    set_seo_meta(@page.title)
    
    fresh_when(etag: @page)
  end
end