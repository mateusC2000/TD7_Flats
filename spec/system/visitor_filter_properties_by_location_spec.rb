require 'rails_helper'

describe 'Visitor filter properties by location' do
  it 'using links on home page' do
    # Arrange
    PropertyLocation.create!(name: 'Centro')
    PropertyLocation.create!(name: 'Sul')
    PropertyLocation.create!(name: 'Norte')

    # Act
    visit root_path

    # Assert
    expect(page).to have_link('Centro')
    expect(page).to have_link('Sul')
    expect(page).to have_link('Norte')
  end

  it 'sucessfully' do
    # Arrange
    apartamento = PropertyType.create!(name: 'Apartamento')
    casa = PropertyType.create!(name: 'Casa')
    property_location = PropertyLocation.create!(name: 'Centro')
    other_property_location = PropertyLocation.create!(name: 'Sul')

    Property.create!({ title: 'Cobertura em Manaus',
                      description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                      rooms: 5, parking_slot: false, bathrooms: 2, daily_rate: 150,
                      property_type: apartamento, property_location: property_location
                    })
    Property.create!({ title: 'Casa com quintal em Copacabana',
                    description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                    rooms: 3, parking_slot: true, bathrooms: 2, daily_rate: 150,
                    property_type: casa, property_location: other_property_location
                  })
    # Act
    visit root_path
    click_on 'Centro'

    # Assert
    expect(page).to have_css('h1', text: 'Imóveis localizados no Centro')
    expect(page).to have_content('Cobertura em Manaus')
    expect(page).not_to have_content('Casa com quintal em Copacabana')
  end

end