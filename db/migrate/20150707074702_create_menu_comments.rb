class CreateMenuComments < ActiveRecord::Migration
  def change
    create_table :menu_comments do |t|
      t.references :menu, index: true, foreign_key: true
      t.references :comment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
