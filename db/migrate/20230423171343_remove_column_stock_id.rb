class RemoveColumnStockId < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :stock_id
  end
end
