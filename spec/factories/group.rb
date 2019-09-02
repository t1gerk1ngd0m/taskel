FactoryBot.define do
  factory :group do
    name       { Faker::App.name }

    trait :group_with_users do
      after(:build) do |group|
        group.users << build(:user)
      end
    end
  end
end
