class AddForeignKeyToAddressId < ActiveRecord::Migration
  def change
		add_foreign_key :addr_conversions, :addresses
  end
end
