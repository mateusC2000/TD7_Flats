class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_location

  validates :title, :description, :rooms, :bathrooms, :daily_rate, presence: { message: 'não pode ficar em branco' }
end
