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
Follow.destroy_all
puts "Creating users..."
sleep 2
# 1. Create a user
User.create!( first_name: "Admin", last_name: "Usuário", furigana: Faker::Name.name, gender: "Male", phone: Faker::PhoneNumber.cell_phone, postal_code: Faker::Number.number(digits: 7), address: Faker::Address.city, email: "admin@usuarioincomum.com", password: "admin123", password_confirmation: "admin123", role: "admin", admin: true )


# 2. Create a user manager
User.create!( first_name: "Active", last_name: "Ltda", furigana: Faker::Name.name, gender: "Male", phone: Faker::PhoneNumber.cell_phone, postal_code: Faker::Number.number(digits: 7), address: Faker::Address.city, role: "manager", email: "active@active.com", password: "active123", password_confirmation: "active123" )

# 3. Create faker users
User.create!( first_name: "Maria", last_name: Faker::Name.last_name, furigana: Faker::Name.name, gender: "Male", phone: Faker::PhoneNumber.cell_phone, postal_code: Faker::Number.number(digits: 7), address: Faker::Address.city, email: "maria@email.com", password: "123456", password_confirmation: "123456" )
User.create!( first_name: "Dario", last_name: Faker::Name.last_name, furigana: Faker::Name.name, gender: "Male", phone: Faker::PhoneNumber.cell_phone, postal_code: Faker::Number.number(digits: 7), address: Faker::Address.city, email: "dario@email.com", password: "123456", password_confirmation: "123456" )
10.times do
  User.create!( first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, furigana: Faker::Name.name, gender: "Male", phone: Faker::PhoneNumber.cell_phone, postal_code: Faker::Number.number(digits: 7), address: Faker::Address.city, email: Faker::Internet.email, password: "123456", password_confirmation: "123456" )
end

puts "Users created!"