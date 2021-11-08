class PropertyReservationMailerPreview < ActionMailer::Preview
  def notify_new_reservation
    property_location = PropertyLocation.create!(name: 'Sul-sudeste')
      property_type = PropertyType.create!(name: 'Qualquer')
      john = PropertyOwner.create!(email: 'lock@down.com.br', password: '123456')
      johns_property = Property.create!(title: 'Apartamento Novo',
                                        description: 'Um apartamento legal',
                                        rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                        property_type: property_type, property_location: property_location,
                                        property_owner: john)

      andrew = User.create!(email: 'quaren@tena.com.br', password: '123456')

      reservation = PropertyReservation.create!(start_date: '2021-12-20', end_date: '2021-12-30',
                                                guests: 6, property: johns_property, user: andrew)

      PropertyReservationMailer.with(reservation: reservation).notify_new_reservation
  end
end
