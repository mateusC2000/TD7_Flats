class PropertyReservationMailer < ApplicationMailer
  def notify_new_reservation
    @reservation = params[:reservation]
    mail(to: @reservation.property.property_owner.email,
         subject: 'Nova reserva para seu imóvel')
  end
end
