class Property < ApplicationRecord
  belongs_to :property_type

  validates :title, :description, :rooms, presence: { message: 'não pode ficar em branco' }
end
