class PropertyType < ApplicationRecord
  validates :name, presence: { message: 'Tipo de imóvel não cadastrado, preencha todos os campos' }
end
