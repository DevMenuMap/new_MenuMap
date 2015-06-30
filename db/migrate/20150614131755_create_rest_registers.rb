class CreateRestRegisters < ActiveRecord::Migration
  def change
    create_table :rest_registers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :email
      t.string :name
      t.references :category, index: true, foreign_key: true
      t.references :subcategory, index: true, foreign_key: true
      t.string :addr
      t.string :phnum
      t.boolean :delivery
      t.string :open_at
      t.text :etc

      t.timestamps null: false
    end
  end
end
