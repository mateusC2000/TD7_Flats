require 'rails_helper'

describe 'user books property' do
  it 'successfully' do
    apartamento = create(:property_type, name: 'Apartamento')
    sul = create(:property_location, name: 'Sul')
    john = create(:property_owner)
    property = create(:property, property_type: apartamento, property_location: sul,
                      property_owner: john, daily_rate: 100)
    
    user = create(:user)
    mailer_spy = class_spy(PropertyReservationMailer)
    stub_const('PropertyReservationMailer', mailer_spy)
    mail = double('PropertyReservationMailer')
    allow(PropertyReservationMailer).to receive(:notify_new_reservation).and_return(mail)
    allow(mail).to receive(:deliver_now)

    login_as user, scope: :user
    visit root_path
    click_on property.title
    fill_in 'Data de início', with: '16/12/2022'
    fill_in 'Data de término', with: '20/12/2022'
    fill_in 'Quantidade de pessoas', with: '3'
    click_on 'Enviar Reserva'
    
    expect(PropertyReservationMailer).to have_received(:notify_new_reservation)
    expect(page).to have_content('16/12/2022')
    expect(page).to have_content('20/12/2022')
    expect(page).to have_content(/3/)
    expect(page).to have_content('R$ 400,00')
    expect(page).to have_content('Pedido de reserva enviado com sucesso')
  end
end
