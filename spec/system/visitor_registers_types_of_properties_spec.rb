require 'rails_helper'

describe 'Visitor registers types of properties' do
  it 'successfully' do

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Enviar'

    expect(page).to have_content('Apartamento')
  end

  it 'successfully' do
    
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Tipo de imóvel não cadastrado, preencha todos os campos')
  end

  it 'successfully' do
    PropertyType.create({ name: 'Apartamento'})

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Enviar'

    expect(page).to have_content('Tipo de imóvel já existente.')
  end

end
