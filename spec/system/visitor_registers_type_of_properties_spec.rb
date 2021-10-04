require 'rails_helper'

describe 'Visitor register types of properties' do
  it 'successfully' do

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Apartamento')
    expect(page).to have_content('Tipo de ímovel cadastrado com sucesso!')
  end

  it 'must not blank fields' do
    
    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: ''
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Nome não pode ficar em branco')
  end

  it 'there must be no repeated names' do
    PropertyType.create({ name: 'Apartamento'})

    visit root_path
    click_on 'Cadastrar tipo de imóvel'
    fill_in 'Nome', with: 'Apartamento'
    click_on 'Criar Tipo de Propriedade'

    expect(page).to have_content('Nome já está em uso')
  end

end
