require 'rails_helper'

describe 'Visitor visit homepage' do
  it 'and view properties' do
    teu = create(:property_owner)
    casa = create(:property_type, name: 'Casa')
    region = create(:property_location, name: 'Norte')
    create(:property, property_type: casa, property_location: region, property_owner: teu)

    create(:property, property_type: casa, property_location: region, property_owner: teu,
           title: 'Cobertura em Manaus', description: 'Cobertura de 300m2, churrasqueira e sauna privativa',
           rooms: 5)

    login_as teu, scope: :property_owner
    visit root_path

    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_text('Quartos: 3')
    expect(page).to have_text('Cobertura em Manaus')
    expect(page).to have_text('Cobertura de 300m2, churrasqueira e sauna privativa')
    expect(page).to have_text('Quartos: 5')
  end

  it 'and theres no property available' do

    visit root_path

    expect(page).to have_text('Nenhum imóvel disponível')
  end

  it 'and view property details' do
    teu = create(:property_owner)
    casa = create(:property_type, name: 'Casa')
    region = create(:property_location, name: 'Norte')
    create(:property, property_type: casa, property_location: region,
           property_owner: teu, title: 'Casa com quintal em Copacabana')

    create(:property, property_type: casa, property_location: region,
           property_owner: teu, title: 'Casa de Vidro',
           description: 'Cobertura de 300m2, churrasqueira e sauna privativa')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'

    expect(page).not_to have_text('Cobertura de 300m2, churrasqueira e sauna privativa')
    expect(page).not_to have_text('Casa de Vidro')
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_text('Quartos: 3')
    expect(page).to have_text('Banheiros: 2')
    expect(page).to have_text('Aceita Pets: Sim')
    expect(page).to have_text('Estacionamento: Sim')
    expect(page).to have_text('Diária: R$ 500,00')
  end

  it 'and view property details and return to home page' do
    teu = create(:property_owner)
    casa = create(:property_type, name: 'Casa')
    region = create(:property_location, name: 'Norte')
    create(:property, property_type: casa, property_location: region,
           property_owner: teu, title: 'Casa com quintal em Copacabana')

    create(:property, property_type: casa, property_location: region,
           property_owner: teu, title: 'Cobertura em Manaus')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Voltar'

    expect(current_path).to eq root_path
    expect(page).to have_text('Casa com quintal em Copacabana')
    expect(page).to have_text('Cobertura em Manaus')
  end
end
