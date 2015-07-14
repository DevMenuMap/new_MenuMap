class CreateAddrBounds < ActiveRecord::Migration
  def change
    create_table :addr_bounds do |t|
      t.references :address, index: true
      t.integer :addr_code

      t.timestamps null: false
    end

		change_column :addr_bounds, :address_id, :bigint
		change_column :addr_bounds, :addr_code, :bigint
  end
end
