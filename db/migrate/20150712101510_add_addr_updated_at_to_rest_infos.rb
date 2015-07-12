class AddAddrUpdatedAtToRestInfos < ActiveRecord::Migration
  def change
		add_column :rest_infos, :addr_updated_at, :datetime
  end
end
