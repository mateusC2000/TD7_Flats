require 'rails_helper'

RSpec.describe PropertyReservation do
  context 'new reservation' do
    it 'should notify property owner' do
      property_location = PropertyLocation.create!(name: 'Sul')
      property_type = PropertyType.create!(name: 'Um tipo qualquer')
      john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
      johns_property = Property.create!(title: 'Apartamento Novo',
                                        description: 'Um apartamento legal',
                                        rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                        property_type: property_type, property_location: property_location,
                                        property_owner: john)

    andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

    reservation = PropertyReservation.create!(start_date: '2021-12-20', end_date: '2021-12-30',
                                              guests: 6, property: johns_property, user: andrew)

    mail = PropertyReservationMailer.with(reservation: reservation).notify_new_reservation

    expect(mail.to).to eq(['john@doe.com.br'])
    expect(mail.from).to eq(['nao-responda@flats.com.br'])
    expect(mail.subject).to eq('Nova reserva para seu imóvel')
    expect(mail.body).to include("Seu imóvel 'Apartamento Novo' foi reservado por andrew@doe.com.br")

    end
  end
end
