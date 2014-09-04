# coding: utf-8
class AddFieldsToSchool < ActiveRecord::Migration
  def change
    add_column :schools, :teach_location, :string # 教学场地
    add_column :schools, :drive_type, :string # 驾照类型 C1, C2
    add_column :schools, :is_3a, :boolean, :default => true # 是否3A资质
    add_column :schools, :is_check, :boolean, :default => true # 是否支持吃拿卡要先行赔付
  end
end
