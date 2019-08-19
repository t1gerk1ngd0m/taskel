# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = Faker::Internet.password(min_length: 6)

  User.create(
    name: name, 
    email: email, 
    password: password
  )
end

10.times do |n|
  name = Faker::Color.color_name

  Label.create(
    name: name
  )
end

100.times do |i|
  title = Faker::Beer.brand
  body = "名前：#{Faker::Beer.name}\nスタイル：#{Faker::Beer.style}\nホップ：#{Faker::Beer.hop}"
  deadline = Faker::Date.between(from: 20.days.ago, to: 1.year.after)
  status = rand(3)
  priority = rand(3)
  created_at= Time.current + i.days

  Task.create(
    title: title, 
    body: body, 
    deadline: deadline, 
    status: status, 
    priority: priority,
    created_at: created_at,
    updated_at: created_at,
    user_id: rand(1..10)
  )
end
