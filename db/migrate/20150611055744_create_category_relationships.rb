class CreateCategoryRelationships < ActiveRecord::Migration
  def change
    create_table :category_relationships do |t|
      t.references :category, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
