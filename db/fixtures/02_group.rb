10.times do |n|
  Group.seed do |s|
    s.name = Faker::App.name
    s.users = [User.find(1), User.find(2), User.find(3)]
    s.owner_user = User.find(rand(1..3))
  end
end
