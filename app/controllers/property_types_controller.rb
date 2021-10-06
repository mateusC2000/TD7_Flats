class PropertyTypesController < ApplicationController
  before_action :authenticate_property_owner!, only: %i[new create]
  def show
    @property_type = PropertyType.find(params[:id])
  end

  def new
    @property_type = PropertyType.new
  end

  def create
    @property_type = PropertyType.new(property_type_params)
    if @property_type.save
      redirect_to @property_type, notice: t('.success')
    else
      render :new
    end

  end

  private

  def property_type_params
    params.require(:property_type).permit(:name)
  end

end
