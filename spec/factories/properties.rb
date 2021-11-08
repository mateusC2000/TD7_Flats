FactoryBot.define do
  factory :property do
    title { 'Casa com quintal em Copacabana' }
    description { 'Excelente casa, recém reformada com 2 vagas de garagem' }
    parking_slot { true }
    rooms { 3 }
    bathrooms { 2 }
    pets { true }
    daily_rate { 500 }
    property_owner
    property_location
    property_type
  end
end
