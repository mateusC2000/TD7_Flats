require 'rails_helper'

describe 'Visitor filter properties by type' do
  it 'using links on home page' do
    # Arrange
    create(:property_type, name: 'Apartamento')
    create(:property_type, name: 'Casa')
    create(:property_type, name: 'Sítio')

    # Act
    visit root_path

    # Assert
    expect(page).to have_link('Apartamento')
    expect(page).to have_link('Casa')
    expect(page).to have_link('Sítio')
  end

  it 'sucessfully' do

    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    apartamento = create(:property_type, name: 'Apartamento')
    casa = create(:property_type, name: 'Casa')
    sul = create(:property_location, name: 'Sul')
    create(:property, property_type: casa, property_location: sul,
           property_owner: teu, title: 'Casa com quintal em Copacabana')

    create(:property, property_type: apartamento, property_location: sul,
           property_owner: teu, title: 'Cobertura em Manaus')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Casa'

    expect(page).to have_css('h1', text: 'Imóveis do tipo Casa')
    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).not_to have_content('Cobertura em Manaus')
  end
end
