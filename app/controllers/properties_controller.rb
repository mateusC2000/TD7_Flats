class PropertiesController < ApplicationController

  before_action :set_properties, only: %i(new create edit update)

  def show
    @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to @property
    else
      render :new
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    @property.update(property_params)
    redirect_to @property
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :bathrooms,
                                     :daily_rate, :pets, :parking_slot, :property_type_id, :property_location_id)
  end

  def set_properties
    @property_types = PropertyType.all
    @property_locations = PropertyLocation.all
    @properties = Property.all
  end
end
