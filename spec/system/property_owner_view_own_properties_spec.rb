require 'rails_helper'

describe 'Property owner view own properties' do
  it 'using menu' do

    teu = create(:property_owner)

    login_as teu, scope: :property_owner
    visit root_path

    expect(page).to have_link('Meus Imóveis', href: my_properties_properties_path)
  end

  it 'and should view owned properties' do

    teu = create(:property_owner)
    kurt = create(:property_owner)
    apartamento = create(:property_type, name: 'Apartamento')
    sul = create(:property_location, name: 'Sul')
    create(:property, property_type: apartamento, property_location: sul,
           property_owner: teu, title: 'Casa com quintal em Copacabana')
    create(:property, property_type: apartamento, property_location: sul,
           property_owner: kurt, title: 'Casa com piscina em Porto Alegre')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'

    expect(page).to have_content('Casa com quintal em Copacabana')
    expect(page).not_to have_content('Casa com piscina em Porto Alegre')
  end

  it 'and has no properties yet' do
    teu = create(:property_owner)

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'

    expect(page).to have_content 'Você ainda não cadastrou imóveis'
    expect(page).to have_link('Cadastre seu primeiro imóvel agora', href: new_property_path)
  end
end
