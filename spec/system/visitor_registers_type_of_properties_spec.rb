require 'rails_helper'

describe 'Visitor register types of properties' do
  it 'successfully' do

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Enviar'

    expect(page).to have_content('Apartamento')
  end

  it 'must not blank fields' do
    
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'there must be no repeated names' do
    PropertyType.create({ name: 'Apartamento'})

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

end
