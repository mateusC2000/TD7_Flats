class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.string :title
      t.string :description
      t.integer :rooms
      t.boolean :parking_slot

      t.timestamps
    end
  end
end
