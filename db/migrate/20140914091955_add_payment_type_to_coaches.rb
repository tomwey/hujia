class AddPaymentTypeToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :payment_type, :string
  end
end
