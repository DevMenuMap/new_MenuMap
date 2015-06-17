class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true
      t.string :addr
      t.string :phnum
      t.boolean :delivery, default: false
      t.integer :menu_on, default: 0
      t.string :open_at
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
