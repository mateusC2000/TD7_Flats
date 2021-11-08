FactoryBot.define do
  factory :property_reservation do
    property
    user
    start_date { 1.week.from_now }
    end_date { 2.weeks.from_now }
    guests { rand(1..10) }
  end
end
