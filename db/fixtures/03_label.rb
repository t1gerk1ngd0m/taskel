10.times do |n|
  Label.seed do |s|
    s.name = Faker::Color.color_name
  end
end
