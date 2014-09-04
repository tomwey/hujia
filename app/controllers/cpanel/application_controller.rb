# coding: utf-8
class Cpanel::ApplicationController < ApplicationController
  layout "cpanel"
  
  before_filter :require_user
  before_filter :require_admin
  
  def require_admin
    if not Settings.admin_emails.include?(current_user.email)
      render_404
    end
  end
  
  def render_list_header(h2, link_text, url)
    html = render(:partial => "cpanel/common/header_list", 
                  :locals => { :h2 => h2, :link_text => link_text, :url => url }).join("\n").html_safe
    html
  end
  helper_method :render_list_header
  
end