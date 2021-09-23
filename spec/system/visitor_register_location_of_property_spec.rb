require 'rails_helper'

describe 'Visitor register location of property' do 
  it 'successfully' do

    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Enviar'

    expect(page).to have_content('Centro-Oeste')
  end

  it 'successfully' do
    
    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Região não cadastrada, preencha todos os campos.')
  end

  it 'successfully' do
    PropertyLocation.create({ name: 'Centro-Oeste'})

    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Enviar'

    expect(page).to have_content('Região já existente.')
  end

end