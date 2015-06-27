class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.references :latlng, polymorphic: true, index: true
      t.decimal :lat, precision: 11, scale: 8
      t.decimal :lng, precision: 11, scale: 8

      t.timestamps null: false
    end
  end
end
