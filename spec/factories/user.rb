FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test_user#{n}" }
    sequence(:email) { |n| "test_email#{n}@example.com" }
    sequence(:password) { "password" }
  end
end