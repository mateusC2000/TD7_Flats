class PropertiesController < ApplicationController
  def show
    id = params[:id]
    @property = Property.find(id)
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

  private

  def property_params
    params.require(:property).permit(:title, :description, :rooms, :bathrooms,
                                     :daily_rate, :pets, :parking_slot, :property_type_id)
  end
end