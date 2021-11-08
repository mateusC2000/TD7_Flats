FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@user.com" }
    password { '1234567890' }
  end
end
