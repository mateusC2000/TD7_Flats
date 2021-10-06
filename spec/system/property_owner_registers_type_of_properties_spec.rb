require 'rails_helper'

describe 'Property owner register types of properties' do
  it 'successfully' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Apartamento')
    expect(page).to have_content('Tipo de ímovel cadastrado com sucesso!')
  end

  it 'must not blank fields' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: ''
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'there must be no repeated names' do
    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')

    PropertyType.create({ name: 'Apartamento'})

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Nome já está em uso')
  end
end
