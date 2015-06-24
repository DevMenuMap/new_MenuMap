class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name, unique: true

      t.timestamps null: false
    end
  end
end
