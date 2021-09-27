class PropertyLocation < ApplicationRecord
  has_many :properties

  validates :name, presence: { message: 'Região não cadastrada, preencha todos os campos.' }
  validates :name, uniqueness: {message: 'Região já existente.'}
end
