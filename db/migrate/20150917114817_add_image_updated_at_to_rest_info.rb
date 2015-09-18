class AddImageUpdatedAtToRestInfo < ActiveRecord::Migration
  def change
		add_column :rest_infos, :img_updated_at, :datetime
  end
end
