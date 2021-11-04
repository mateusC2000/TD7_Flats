class PropertiesController < ApplicationController
  before_action :authenticate_property_owner!, only: %i[new create]
  before_action :set_property_types, only: %i[new create edit update]
  before_action :set_property_locations, only: %i[new create edit update]
  before_action :set_property, only: %i[show edit update]

  def show
    @property_reservation = PropertyReservation.new
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @property.property_owner = current_property_owner
    if @property.save
      redirect_to @property, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @property.update(property_params)
      redirect_to @property, notice: t('.success')
    else
      render :edit
    end
  end

  def my_properties
    @properties = current_property_owner.properties
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :bathrooms,
                                     :daily_rate, :pets, :parking_slot, :property_type_id,
                                     :property_location_id, :property_owner_id)
  end

  def set_property_types
    @property_types = PropertyType.all
  end

  def set_property_locations
    @property_locations = PropertyLocation.all
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
