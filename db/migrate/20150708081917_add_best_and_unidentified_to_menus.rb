class AddBestAndUnidentifiedToMenus < ActiveRecord::Migration
  def change
		# When price is unidentified
		add_column :menus, :unidentified, :boolean, default: false
		add_column :menus, :best, :integer, default: 0
  end
end
