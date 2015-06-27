class CreateAddrRules < ActiveRecord::Migration
  def change
    create_table :addr_rules do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
