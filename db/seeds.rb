# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Cleaning database..."
sleep 1

User.destroy_all
puts "Creating users..."
sleep 2
# 1. Create a user
User.create!( email: "admin@usuarioincomum.com", password: "admin123", password_confirmation: "admin123", role: "admin", admin: true )


# 2. Create a user manager
User.create!( first_name: "Active", last_name: "Ltda", role: "manager", email: "active@active.com", password: "active123", password_confirmation: "active123" )

# 3. Create faker users
User.create!( first_name: "Maria", email: "maria@email.com", password: "123456", password_confirmation: "123456")
User.create!( first_name: "Dario", email: "dario@email.com", password: "123456", password_confirmation: "123456")
10.times do
  User.create!( first_name: Faker::Name.first_name, email: Faker::Internet.email, password: "123456", password_confirmation: "123456" )
end

puts "Users created!"