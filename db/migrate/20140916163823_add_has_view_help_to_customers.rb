class AddHasViewHelpToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :has_view_help, :boolean, :default => false
  end
end
