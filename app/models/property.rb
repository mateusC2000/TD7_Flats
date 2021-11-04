class Property < ApplicationRecord
  belongs_to :property_type
  belongs_to :property_location
  belongs_to :property_owner

  has_many :property_reservations, dependent: :destroy

  validates :title, :description, :rooms, :bathrooms, :daily_rate, presence: true
  validates :rooms, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :bathrooms, numericality: { greater_than: 0, only_integer: true }
  validates :daily_rate, numericality: { greater_than: 0 }
end
