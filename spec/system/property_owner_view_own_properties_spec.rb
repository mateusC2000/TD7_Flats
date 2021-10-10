require 'rails_helper'

describe 'Property owner view own properties' do
  it 'using menu' do
    # Arrange
    property_owner = PropertyOwner.create!(email: 'teue@shelby.com.br', password: '123456789')

    # Act
    login_as property_owner, scope: :property_owner
    visit root_path

    # Assert
    expect(page).to have_link('Meus Imóveis', href: my_properties_properties_path)
  end

  it 'and should view owned properties' do
    # Arrange
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    kurt = PropertyOwner.create!(email: 'kurt@weler.com.br', password: '123456789')

    sul = PropertyLocation.create!(name: 'Sul')
    casa = PropertyType.create!(name: 'Casa')
    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
                       property_type: casa, property_location: sul, property_owner: teu })
    Property.create!({ title: 'Casa com piscina em Porto Alegre',
                       description: 'Ótima casa, com todos acessórios e internet rápida',
                       rooms: 2, parking_slot: false, bathrooms: 1, daily_rate: 100,
                       property_type: casa, property_location: sul, property_owner: kurt })

    # Act
    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'

    # Assert
    expect(page).to have_content 'Casa com quintal em Copacabana'
    expect(page).not_to have_content 'Casa com piscina em Porto Alegre'
  end

  it 'and has no properties yet' do
    teu = PropertyOwner.create!(email: 'teur@shelby.com.br', password: '123456789')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'

    expect(page).to have_content 'Você ainda não cadastrou imóveis'
    expect(page).to have_link('Cadastre seu primeiro imóvel agora', href: new_property_path)
  end
end
