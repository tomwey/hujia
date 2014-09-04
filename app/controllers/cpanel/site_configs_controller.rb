# coding: utf-8
class Cpanel::SiteConfigsController < Cpanel::ApplicationController
  
  before_filter :require_super_admin
  
  def index
    @site_configs = SiteConfig.order("id DESC")
  end
  
  def new
    @site_config = SiteConfig.new()
  end
  
  def create
    @site_config = SiteConfig.new(params[:site_config])
    if @site_config.save
      redirect_to edit_cpanel_site_config_path(@site_config), :notice => "配置创建成功"
    else
      render :new
    end
  end
  
  def edit
    @site_config = SiteConfig.find(params[:id])
  end
  
  def update
    @site_config = SiteConfig.find(params[:id])
    if @site_config.update_attributes(params[:site_config])
      redirect_to edit_cpanel_site_config_path(@site_config), :notice => "配置更新成功。"
    else
      render :edit
    end
  end
  
  private
  
  def require_super_admin
    if not current_user.super_admin? #Settings.admin_emails.include?(current_user.email)
      render_404
    end
  end
  
end
