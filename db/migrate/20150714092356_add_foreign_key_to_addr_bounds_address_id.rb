class AddForeignKeyToAddrBoundsAddressId < ActiveRecord::Migration
  def change
		add_foreign_key :addr_bounds, :addresses
  end
end
