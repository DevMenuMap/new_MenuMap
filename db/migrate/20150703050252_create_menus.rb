class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.references :menu_title, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :side_info
      t.integer :price
      t.string :info
      t.boolean :sitga, default: false
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
