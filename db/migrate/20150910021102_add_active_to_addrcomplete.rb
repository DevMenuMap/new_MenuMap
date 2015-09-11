class AddActiveToAddrcomplete < ActiveRecord::Migration
  def change
		add_column :addrcompletes, :active, :boolean, default: true
  end
end
