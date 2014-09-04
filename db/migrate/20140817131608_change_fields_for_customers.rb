# coding: utf-8
class ChangeFieldsForCustomers < ActiveRecord::Migration
  def up
    remove_column :customers, :city
    remove_column :customers, :location
    
    add_column :customers, :score, :integer, :default => 0 # 积分
    add_column :customers, :id_number, :string # 身份证号
    add_column :customers, :qq, :string
    add_column :customers, :is_student, :boolean, :default => true
    add_column :customers, :college, :string # 大学
    
    add_index :customers, :id_number, :unique => true
  end
  
end
