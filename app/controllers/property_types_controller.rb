class PropertyTypesController < ApplicationController
  def show
    id = params[:id]
    @property_type = PropertyType.find(id)
  end
  def new
    @property_type = PropertyType.new
  end
  def create
    types_params = PropertyType.create(params.require(:property_type).permit(:name))

    redirect_to property_type_path(types_params.id)
  end
end