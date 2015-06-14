class CreateRestRegisters < ActiveRecord::Migration
  def change
    create_table :rest_registers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :email
      t.string :name
      t.string :cat
      t.string :subcat
      t.string :addr
      t.string :phnum
      t.boolean :delivery
      t.string :open_at
      t.text :etc

      t.timestamps null: false
    end
  end
end
