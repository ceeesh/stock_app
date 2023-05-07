class AddSymbolToUserStock < ActiveRecord::Migration[7.0]
  def change
    add_column :user_stocks, :symbol, :string
    add_column :user_stocks, :company_name, :string
  end
end

