class CreateRestErrs < ActiveRecord::Migration
  def change
    create_table :rest_errs do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :presence_err, default: false
      t.boolean :menu_err, 		 default: false
      t.boolean :phnum_err, 	 default: false
      t.boolean :category_err, default: false
      t.text :etc
      t.boolean :active, 			 default: true

      t.timestamps null: false
    end
  end
end
