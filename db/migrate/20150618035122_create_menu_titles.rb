class CreateMenuTitles < ActiveRecord::Migration
  def change
    create_table :menu_titles do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.string :title_name
      t.string :title_info
      t.boolean :active, 		default: true

      t.timestamps null: false
    end
  end
end
