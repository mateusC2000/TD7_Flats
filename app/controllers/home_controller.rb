class HomeController < ApplicationController
  def index
    @property_locations = PropertyLocation.all
    @property_types = PropertyType.all
    @properties = Property.all
  end
end
