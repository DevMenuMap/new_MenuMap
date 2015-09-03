class AddMenuOnIndexToRestaurants < ActiveRecord::Migration
  def change
  	add_index :restaurants, :menu_on
  end
end
