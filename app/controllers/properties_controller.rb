class PropertiesController < ApplicationController

  before_action :set_properties, only: %i(new create edit update)
  before_action :set_property_types, only: %i(new create edit update)
  before_action :set_property_locations, only: %i(new create edit update)
  before_action :set_property, only: %i(show edit update)

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to @property, notice: 'Propriedade criada com sucesso!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @property.update(property_params)
      redirect_to @property
    else
      flash[:alert] = 'Você deve preencher todos os campos.'
      render :edit
    end
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :bathrooms,
                                     :daily_rate, :pets, :parking_slot, :property_type_id, :property_location_id)
  end

  def set_properties
    @properties = Property.all
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
