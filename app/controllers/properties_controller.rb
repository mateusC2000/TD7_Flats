class PropertiesController < ApplicationController
  def show
    @property = Property.find(params[:id])
  end
  def new
    @property = Property.new
  end
  def create
    prop = Property.create(params.require(:property).permit(:title, :description, :rooms,
                                                                :bathrooms, :daily_rate,
                                                                :pets, :parking_slot))
    redirect_to property_path(prop.id)
  end

end