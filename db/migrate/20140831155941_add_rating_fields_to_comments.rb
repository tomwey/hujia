# coding: utf-8
class AddRatingFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :overall_rating,  :float, :default => 0 # 总体评价
    add_column :comments, :attitude_rating, :float, :default => 0 # 态度评价
    add_column :comments, :service_rating,  :float, :default => 0 # 服务评价
    add_column :comments, :env_rating,      :float, :default => 0 # 环境评价
  end
end
