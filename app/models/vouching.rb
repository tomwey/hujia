# coding: utf-8
# 领取
class Vouching < ActiveRecord::Base
  attr_accessible :coupon_id, :user_id
  
  belongs_to :user
  belongs_to :coupon#, :counter_cache => true
end
