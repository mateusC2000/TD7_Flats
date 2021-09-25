class Property < ApplicationRecord
  validates :title, :description, :rooms, presence: {message: 'não pode ficar em branco'}
end
