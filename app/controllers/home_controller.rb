# coding: utf-8
class HomeController < ApplicationController
  
  # cache_pages [:coupon_use_intro, :deposit_guarantee, :compensate_apply, :interest_protect, :user_agreement,  :help_center]
  
  def index
    @coaches = Coach.needed_fields.includes(:coupons, :comments).visibled.hot.limit(5)
    @colleges = College.joins(:city).where("cities.code = ?", "511300").sorted
    @banners = Banner.visibled.sorted.limit(4)
    
    set_seo_meta("首页", "U驾网，驾校，学车，教练，驾校维权", "U驾网可以为教练或驾校提供一个平台，更多、更好、更方便的找到学员；同时为也是学员的一个平台，学员可以通过U驾网平台进行维权！")
  end
  
  def error_404
    render_404
  end
  
  def coupon_use_intro
    set_seo_meta("代金券使用")
  end
  
  def deposit_guarantee
    set_seo_meta("保证金担保")
  end
  
  def compensate_apply
    set_seo_meta("赔付申请")
  end
  
  def interest_protect
    set_seo_meta("权益保护")
  end
  
  def user_agreement
    set_seo_meta("用户协议")
  end
  
  def help_center
    set_seo_meta("维权中心")
  end
  
end