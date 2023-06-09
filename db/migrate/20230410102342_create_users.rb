class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :token
      t.boolean :admin, default: false
      t.boolean :email_verification, default: false

      t.timestamps
    end
  end
end
