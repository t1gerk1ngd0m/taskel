FactoryBot.define do
  factory :task do
    association :user
    association :group
    title       {"aaa"}
    body        {"本文"}
    deadline    {'2019-08-09'}
    status      {1}
    file        {"aaaaa"}
    priority    {0}
  end
end
