class AddMenuUpdatedAtToRestInfos < ActiveRecord::Migration
  def change
		add_column :rest_infos, :menu_updated_at, :datetime
  end
end
