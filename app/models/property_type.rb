class PropertyType < ApplicationRecord
  validates :name, presence: { message: 'Tipo de imóvel não cadastrado, preencha todos os campos' }
  validates :name, uniqueness: {message: 'Tipo de imóvel já existente.'}
end
