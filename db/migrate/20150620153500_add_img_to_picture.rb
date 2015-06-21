class AddImgToPicture < ActiveRecord::Migration
  def up
		add_attachment :pictures, :img
  end

  def down
		remove_attachment :pictures, :img
  end
end
