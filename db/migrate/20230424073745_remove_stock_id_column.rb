class RemoveStockIdColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_stocks, :stock_id
  end
end
