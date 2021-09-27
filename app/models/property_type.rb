class PropertyType < ApplicationRecord
  has_many :properties

  validates :name, presence: { message: 'Tipo de imóvel não cadastrado, preencha todos os campos' }
  validates :name, uniqueness: { message: 'Tipo de imóvel já existente.' }
end
