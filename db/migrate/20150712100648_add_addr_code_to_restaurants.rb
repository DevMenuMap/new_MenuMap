class AddAddrCodeToRestaurants < ActiveRecord::Migration
  def change
		add_column :restaurants, :addr_code, :integer
		change_column :restaurants, :addr_code, :bigint
		add_index :restaurants, :addr_code
  end
end
