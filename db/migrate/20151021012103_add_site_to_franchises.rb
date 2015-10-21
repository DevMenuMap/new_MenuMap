class AddSiteToFranchises < ActiveRecord::Migration
  def change
		add_column :franchises, :site, :string
  end
end
