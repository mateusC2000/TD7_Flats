require 'rails_helper'

describe 'Owner edits property data' do
  it 'sucessfully' do
    teu = create(:property_owner)
    casa = create(:property_type, name: 'Casa')
    sul = create(:property_location, name: 'Sul')
    create(:property, property_owner: teu, property_type: casa,
           property_location: sul, title: 'Casa com quintal em Copacabana')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Editar'

    select 'Casa', from: 'Tipo'
    select 'Sul', from: 'Região'
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
    teu = create(:property_owner)
    casa = create(:property_type, name: 'Casa')
    sul = create(:property_location, name: 'Sul')
    create(:property, property_owner: teu, property_type: casa,
           property_location: sul, title: 'Casa com quintal em Copacabana')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Casa com quintal em Copacabana'
    click_on 'Editar'

    select 'Casa', from: 'Tipo'
    select 'Sul', from: 'Região'
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
