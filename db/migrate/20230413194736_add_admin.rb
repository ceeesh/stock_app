class AddAdmin < ActiveRecord::Migration[7.0]
  def change
    User.create! do |u|
      u.email = 'admin@test.com'
      u.password = 'password'
      u.admin = true
    end
  end
end
