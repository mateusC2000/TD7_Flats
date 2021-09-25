class PropertyLocationsController < ApplicationController

  def new
    @property_locations = PropertyLocation.all
    @property_location = PropertyLocation.new
  end

  def show
    @property_locations = PropertyLocation.all
    @property_location = PropertyLocation.find(params[:id])
  end

  def create
    @property_location = PropertyLocation.new(property_location_params)
    if @property_location.save
      redirect_to @property_location
    else
      render :new
    end
  end

  private

  def property_location_params
    params.require(:property_location).permit(:name)
  end

end