class NotifyReservationMailerJob
  include Sidekiq::Job

  def perform(property_reservation)
    PropertyReservationMailer.with(reservation: property_reservation).notify_new_reservation.deliver_now
  end
  
end
