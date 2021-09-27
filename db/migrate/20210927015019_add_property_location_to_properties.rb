class AddPropertyLocationToProperties < ActiveRecord::Migration[6.1]
  def change
    add_reference :properties, :property_location, null: false, foreign_key: true
  end
end
