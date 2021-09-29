require 'rails_helper'

describe 'Visitor register property' do
  
  it 'successfully' do
    #Arrange
    PropertyType.create!(name: 'Casa')
    PropertyType.create!(name: 'Apartamento')
    PropertyLocation.create!(name: 'Centro-Oeste')
    PropertyLocation.create!(name: 'Sudeste')

    #Act
    visit root_path
    click_on 'Cadastrar imóvel'
    select 'Casa', from: 'Tipo'
    select 'Sudeste', from: 'Região'
    fill_in 'Título', with: 'Casa em Florianópolis'
    fill_in 'Descrição', with: 'Ótima casa perto da UFSC'
    fill_in 'Quartos', with: '3'
    fill_in 'Banheiros', with: '2'
    fill_in 'Diária', with: 200
    check 'Aceita Pets'
    check 'Vaga de Estacionamento'
    click_on 'Enviar'

    expect(page).to have_content('Casa em Florianópolis')
    expect(page).to have_content("Ótima casa perto da UFSC")
    expect(page).to have_content("Quartos: 3")
    expect(page).to have_content("Banheiros: 2")
    expect(page).to have_content("Diária: R$ 200,00")
    expect(page).to have_content("Aceita Pets: Sim")
    expect(page).to have_content("Estacionamento: Sim")
  end

  it 'and must fill all fields' do
    visit root_path
    click_on 'Cadastrar imóvel'
    click_on 'Enviar'

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Quartos não pode ficar em branco')
    expect(page).to have_content('Banheiros não pode ficar em branco')
    expect(page).to have_content('Diária não pode ficar em branco')
    expect(Property.count).to eq(0)
  end
end
