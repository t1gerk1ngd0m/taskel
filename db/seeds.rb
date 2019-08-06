# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

s1 = Date.parse("2019-01-01")
s2 = Date.parse("2020-01-01")

100.times do |i|
  Task.create(title: "タスクタイトル#{i}", body: "タスク本文#{rand(i)}", deadline: Random.rand(s1 .. s2), status: rand(3), created_at: Time.current + i.days)
end
