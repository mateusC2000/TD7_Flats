require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'and view properties' do
    #Arrange => Preparar (os dados)
    property_type = PropertyType.create!(name: 'Casa')
    other_property_type = PropertyType.create!(name: 'Apartamento')
    region = PropertyLocation.create!(name: 'Norte')
    other_region = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Casa com quintal em Copacabana', 
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, bathrooms: 2, daily_rate: 200, parking_slot: true,
                       property_type: property_type, property_location: other_region
                    })

    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, bathrooms: 2, daily_rate: 200, parking_slot: false,
                       property_type: other_property_type, property_location: region
                    })

    #Act => Agir (executar a funcionalidade)
    visit root_path

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    # 2 imoveis -> casa em copacabana; apartamento em manaus
    expect(page).to have_text("Casa com quintal em Copacabana")
    expect(page).to have_text("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_text("Quartos: 3")
    expect(page).to have_text("Cobertura em Manaus")
    expect(page).to have_text("Cobertura de 300m2, churrasqueira e sauna privativa")
    expect(page).to have_text("Quartos: 5")
  end

  it 'and theres no property available' do
    #Arrange => Preparar (os dados)

    #Act => Agir (executar a funcionalidade)
    visit root_path
    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    expect(page).to have_text("Nenhum imóvel disponível")
  end

  it 'and view property details' do
    #Arrange => Preparar (os dados)
    property_type = PropertyType.create!(name: 'Casa')
    other_property_type = PropertyType.create!(name: 'Apartamento')
    region = PropertyLocation.create!(name: 'Norte')
    other_region = PropertyLocation.create!(name: 'Sudeste')

    property = Property.create!({ title: 'Casa com quintal em Copacabana', 
                                  description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                                  rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                                 property_type: property_type, property_location: other_region
                    })

    Property.create!({ title: 'Cobertura em Manaus',
                    description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                    rooms: 5, parking_slot: false, bathrooms: 2, pets: true, daily_rate: 500,
                    property_type: other_property_type, property_location: region
                  })

    #Act => Agir (executar a funcionalidade)
    visit root_path
    click_on 'Casa com quintal em Copacabana'

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    expect(page).not_to have_text('Cobertura de 300m2, churrasqueira e sauna privativa')
    expect(page).to have_text("Casa com quintal em Copacabana")
    expect(page).to have_text("Excelente casa, recém reformada com 2 vagas de garagem")
    expect(page).to have_text("Quartos: 3")
    expect(page).to have_text("Banheiros: 2")
    expect(page).to have_text("Aceita Pets: Sim")
    expect(page).to have_text("Estacionamento: Sim")
    expect(page).to have_text("Diária: R$ 500,00")
  end

  it 'and view property details and return to home page' do
    property_type = PropertyType.create!(name: 'Casa')
    other_property_type = PropertyType.create!(name: 'Apartamento')
    region = PropertyLocation.create!(name: 'Norte')
    other_region = PropertyLocation.create!(name: 'Sudeste')

    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, parking_slot: true, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: property_type, property_location: other_region
                    })

    Property.create!({ title: 'Cobertura em Manaus',
                       description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
                       rooms: 5, parking_slot: false, bathrooms: 2, pets: true, daily_rate: 500,
                       property_type: other_property_type, property_location: region
                    })
    #Act => Agir (executar a funcionalidade)
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Voltar'

    #Assert => Garantir (que algo aconteceu ou NAO aconteceu)
    expect(current_path).to eq root_path
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Cobertura em Manaus')
  end

end