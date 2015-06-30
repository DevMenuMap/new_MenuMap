class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :imageable, polymorphic: true, index: true
			t.string :name
			t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
