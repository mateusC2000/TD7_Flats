FactoryBot.define do
  factory :property_owner do
    sequence(:email) { |n| "owner#{n}@owner.com" }
    password { '1234567890' }
  end
end
