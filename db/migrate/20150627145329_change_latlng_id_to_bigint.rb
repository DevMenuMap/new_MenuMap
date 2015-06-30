class ChangeLatlngIdToBigint < ActiveRecord::Migration
  def change
		change_column :coordinates, :latlng_id, :bigint
  end
end
