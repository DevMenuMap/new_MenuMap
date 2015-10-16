class AddSiteToRestaurants < ActiveRecord::Migration
  def change
		add_column :restaurants, :site, :string
  end
end
