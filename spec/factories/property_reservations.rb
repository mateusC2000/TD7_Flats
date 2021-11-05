FactoryBot.define do
  factory :property_reservation do
    start_date { '2021-12-20' }
    end_date { '2021-12-30' }
    guests { 6 }
    property
    user
  end
end
