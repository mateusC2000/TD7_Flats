require 'rails_helper'

describe 'Property owner register location of property' do
  it 'successfully' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Cadastrar Região'

    expect(page).to have_content('Centro-Oeste')
    expect(page).to have_content('Região cadastrada com sucesso!')
  end

  it 'must not blank fields' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: ''
    click_on 'Cadastrar Região'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'there must be no repeated names' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    PropertyLocation.create({ name: 'Centro-Oeste'})

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar região'
    fill_in 'Nome', with: 'Centro-Oeste'
    click_on 'Cadastrar Região'

    expect(page).to have_content('Nome já está em uso')
  end
end
