class PropertyReservationsController < ApplicationController
  def show
    @property_reservation = PropertyReservation.find(params[:id])
  end

  def create
    @property_reservation = PropertyReservation.new(property_reservation_params)
    @property_reservation.user = current_user
    @property_reservation.property = Property.find(params[:property_id])
    @property_reservation.save

    redirect_to @property_reservation, notice: 'Pedido de reserva enviado com sucesso'
  end

  def accept
    @property_reservation = PropertyReservation.find(params[:id])
    @property_reservation.accepted!
    redirect_to @property_reservation.property
  end

  private

  def property_reservation_params
    params.require(:property_reservation).permit(:start_date, :end_date, :guests)
  end
end
