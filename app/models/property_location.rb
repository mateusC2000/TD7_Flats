class PropertyLocation < ApplicationRecord
  validates :name, presence: { message: 'Região não cadastrada, preencha todos os campos.' }
end
