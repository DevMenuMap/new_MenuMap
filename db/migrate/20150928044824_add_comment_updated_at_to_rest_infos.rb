class AddCommentUpdatedAtToRestInfos < ActiveRecord::Migration
  def change
		add_column :rest_infos, :comment_updated_at, :datetime
  end
end
