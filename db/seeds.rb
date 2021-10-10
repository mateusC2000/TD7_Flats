property_location = PropertyLocation.create!(name: 'Sul')
property_type = PropertyType.create!(name: 'Um tipo qualquer')
john = PropertyOwner.create!(email: 'john@doe.com.br', password: '123456')
johns_property = Property.create!(title: 'Apartamento Novo',
                                  description: 'Um apartamento legal',
                                  rooms: 3, bathrooms: 2, pets: true, daily_rate: 100,
                                  property_type: property_type, property_location: property_location,
                                  property_owner: john)

andrew = User.create!(email: 'andrew@doe.com.br', password: '123456')

PropertyReservation.create!(start_date: '2021-10-30', end_date: '2021-11-05',
                            guests: 6, property: johns_property, user: andrew)

p 'Banco de dados populados com sucesso!!'
