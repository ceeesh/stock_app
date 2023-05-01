# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
include BCrypt


# User.create!(email: "admin@test.com" , password: Password.create('admin'), admin: true)

(1..100).each do |i|
    Post.create(title: "Title #{i}",
        created_at: Time.now - i.days,
        updated_at: Time.now - i.days,
        views: rand(15..100) / (i * 0.1))
end


    User.create! do |u|
      u.email = 'admin@test.com'
      u.password = 'password'
      u.admin = true
    end
