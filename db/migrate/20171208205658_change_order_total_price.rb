class ChangeOrderTotalPrice < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :decimal
    remove_column :orders, :total_price
    add_column :orders, :total_price, :decimal
  end
end
