require 'rails_helper'

describe 'Visitor filter properties by location' do
  it 'using links on home page' do

    create(:property_location, name: 'Sul')
    create(:property_location, name: 'Norte')
    create(:property_location, name: 'Centro')

    visit root_path

    # Assert
    expect(page).to have_link('Centro')
    expect(page).to have_link('Sul')
    expect(page).to have_link('Norte')
  end

  it 'sucessfully' do

    teu = PropertyOwner.create!(email: 'teu@shelby.com.br', password: '123456789')
    casa = create(:property_type, name: 'Casa')
    sul = create(:property_location, name: 'Sul')
    centro = create(:property_location, name: 'Centro')
    create(:property, property_type: casa, property_location: sul,
           property_owner: teu, title: 'Casa com quintal em Copacabana')

    create(:property, property_type: casa, property_location: centro,
           property_owner: teu, title: 'Cobertura em Manaus')

    login_as teu, scope: :property_owner
    visit root_path
    click_on 'Centro'

    # Assert
    expect(page).to have_css('h1', text: 'Imóveis localizados no Centro')
    expect(page).to have_content('Cobertura em Manaus')
    expect(page).not_to have_content('Casa com quintal em Copacabana')
  end
end
