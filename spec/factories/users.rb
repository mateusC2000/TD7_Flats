FactoryBot.define do
  factory :user do
    email { generate(:email) }
    password { '1234567890' }
  end
end

FactoryBot.define do
  sequence :gmail do |n|
    "user#{n}@gmail.com"
  end
end
