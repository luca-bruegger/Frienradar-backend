# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

3.times do |index|
  User.create!(
    name: Faker::Name.name,
    email: "test_#{index}@test.com",
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.now.utc
  )
end