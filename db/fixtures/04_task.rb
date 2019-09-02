100.times do |n|
  Task.seed do |s|
    s.title = Faker::Beer.brand
    s.body = "名前：#{Faker::Beer.name}\nスタイル：#{Faker::Beer.style}\nホップ：#{Faker::Beer.hop}"
    s.deadline = Faker::Date.between(from: 20.days.ago, to: 1.year.after)
    s.status = rand(3)
    s.priority = rand(3)
    s.created_at= Time.current + n.days
    s.group_id = rand(1..10)
    s.user_id = rand(1..3)
    s.labels = [Label.find(rand(1..3)), Label.find(rand(4..6)), Label.find(rand(7..10))]
  end
end
