class CreateAddrConversions < ActiveRecord::Migration
  def change
    create_table :addr_conversions do |t|
      t.references :address, index: true
      t.string :convert_to
      t.string :convert_from

      t.timestamps null: false
    end

    add_index :addr_conversions, :convert_from
		change_column :addr_conversions, :address_id, :bigint
  end
end
