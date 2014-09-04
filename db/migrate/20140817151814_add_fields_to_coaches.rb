# coding: utf-8
class AddFieldsToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :drive_type, :string # 驾照类型
    add_column :coaches, :service_area, :string # 服务区域
    add_column :coaches, :is_check, :boolean, :default => true # 是否支持吃拿卡先行赔付
    rename_column :coaches, :pickup_location, :teach_location # 教学场地
    
  end
end
