class HomeController < ApplicationController
  def index
    @property_types = PropertyType.all
    @properties = Property.all
  end
end
