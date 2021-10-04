require 'rails_helper'

describe 'Visitor register location of property' do
  it 'successfully' do

    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Cadastrar Região'

    expect(page).to have_content('Centro-Oeste')
    expect(page).to have_content('Região cadastrada com sucesso!')
  end

  it 'must not blank fields' do
    
    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar Região'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'there must be no repeated names' do
    PropertyLocation.create({ name: 'Centro-Oeste'})

    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Cadastrar Região'

    expect(page).to have_content('Nome já está em uso')
  end

end