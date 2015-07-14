class CreateAddrTags < ActiveRecord::Migration
  def change
    create_table :addr_tags do |t|
      t.references :address, index: true
      t.references :restaurant, index: true, foreign_key: true
      t.boolean :active, default: false

      t.timestamps null: false
    end

		change_column :addr_tags, :address_id, :bigint
  end
end
