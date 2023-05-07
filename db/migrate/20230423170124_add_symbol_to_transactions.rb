class AddSymbolToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :symbol, :string
  end
end
