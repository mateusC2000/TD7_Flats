require 'rails_helper'

describe 'Owner edits property data' do
  it 'sucessfully' do
    property_owner = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    region = PropertyLocation.create!(name: 'Sudeste')
    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, bathrooms: 2, daily_rate: 200, parking_slot: true, pets: false,
                       property_type: property_type, property_location: region})

    # simula a ação do usuário
    login_as property_owner, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Editar'

    select 'Casa', from: 'Tipo'
    select 'Sudeste', from: 'Região'
    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Excelente casa, recém reformada com 2 vagas de garagem'
    fill_in 'Quartos', with: '2'
    fill_in 'Banheiros', with: '3'
    fill_in 'Diária', with: 300
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'

    click_on 'Atualizar Propriedade'

    expect(page).to have_content('Casa em Florianópolis')
    expect(page).to have_content('Excelente casa, recém reformada com 2 vagas de garagem')
    expect(page).to have_content('Quartos: 2')
    expect(page).to have_content('Banheiros: 3')
    expect(page).to have_content('Diária: R$ 300,00')
    expect(page).to have_content('Aceita Pets: Sim')
    expect(page).to have_content('Estacionamento: Sim')
    expect(page).to have_content('Propriedade atualizada com sucesso')
  end

  it 'and must fill in all fields' do
    property_owner = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    property_type = PropertyType.create!(name: 'Casa')
    region = PropertyLocation.create!(name: 'Sudeste')
    Property.create!({ title: 'Casa com quintal em Copacabana',
                       description: 'Excelente casa, recém reformada com 2 vagas de garagem',
                       rooms: 3, bathrooms: 2, daily_rate: 200, parking_slot: true, pets: false,
                       property_type: property_type, property_location: region})

    # simula a ação do usuário
    login_as property_owner, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Editar'

    select 'Casa', from: 'Tipo'
    select 'Sudeste', from: 'Região'
    fill_in 'Título', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Quartos', with: ''
    fill_in 'Banheiros', with: ''
    fill_in 'Diária', with: ''
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'

    click_on 'Atualizar Propriedade'

    expect(page).to have_content('não pode ficar em branco', count: 5)
  end
end
