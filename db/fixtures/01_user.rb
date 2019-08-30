10.times do |n|
  User.seed do |s|
    s.name = Faker::Name.name
    s.email = "aaa#{n}@ggg.com"
    s.password = "123456"
  end
end

User.create(
  name: "admin", 
  email: "ttttt@yahoo.com", 
  password: "123456",
  role: 1
)
