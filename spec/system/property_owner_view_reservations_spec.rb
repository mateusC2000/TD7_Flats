require 'rails_helper'

describe 'Property owner view reservations' do
  it 'should view reservations from owned properties' do
    apartamento = create(:property_type, name: 'Apartamento')
    sul = create(:property_location, name: 'Sul')
    john = create(:property_owner)
    property = create(:property, property_type: apartamento, property_location: sul,
                      property_owner: john, title: 'Apartamento Novo')

    andrew = create(:user)
    create(:property_reservation, property: property, user: andrew,
           start_date: '20/12/2021', end_date: '30/12/2021', guests: 6)

    login_as john, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Apartamento Novo'

    expect(page).not_to have_content 'Reserve Agora'
    expect(page).to have_content 'Reservas'
    expect(page).to have_content "Reserva de #{andrew.email}"
    expect(page).to have_content 'Data de Início: 20/12/2021'
    expect(page).to have_content 'Data de Saída: 30/12/2021'
    expect(page).to have_content 'Total de Pessoas: 6'
    expect(page).to have_content 'Status: Pendente'
  end

  it 'and does not view other properties reservation' do
    apartamento = create(:property_type, name: 'Apartamento')
    sul = create(:property_location, name: 'Sul')
    john = create(:property_owner)
    jane = create(:property_owner)
    create(:property, property_type: apartamento, property_location: sul,
           property_owner: john, title: 'Apartamento Novo')
    jane_property = create(:property, property_type: apartamento, property_location: sul,
                           property_owner: jane, title: 'Apartamento Vintage')

    andrew = create(:user)
    create(:property_reservation, property: jane_property, user: andrew)

    login_as john, scope: :property_owner
    visit root_path
    click_on 'Apartamento Vintage'

    expect(page).not_to have_content('Reserve Agora')
    expect(page).not_to have_content("Reserva de #{andrew.email}")
    expect(page).not_to have_content('Data de Início: 20/12/2021')
    expect(page).not_to have_content('Data de Saída: 30/12/2021')
  end

  it 'and accept reservation' do
    apartamento = create(:property_type, name: 'Apartamento')
    sul = create(:property_location, name: 'Sul')
    john = create(:property_owner)
    property = create(:property, property_type: apartamento, property_location: sul,
                      property_owner: john, title: 'Apartamento Novo')

    andrew = create(:user)
    create(:property_reservation, property: property, user: andrew,
           start_date: '20/12/2021', end_date: '30/12/2021', guests: 6)

    login_as john, scope: :property_owner
    visit root_path
    click_on 'Meus Imóveis'
    click_on 'Apartamento Novo'
    click_on 'Aceitar Reserva'

    expect(current_path).to eq property_path(property)
    expect(page).to have_content 'Reservas'
    expect(page).to have_content "Reserva de #{andrew.email}"
    expect(page).to have_content 'Data de Início: 20/12/2021'
    expect(page).to have_content 'Data de Saída: 30/12/2021'
    expect(page).to have_content 'Total de Pessoas: 6'
    expect(page).to have_content 'Status: Aceita'
  end
end
