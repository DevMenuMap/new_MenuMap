class RemoveImgFromRestRegister < ActiveRecord::Migration
  def change
		remove_attachment :rest_registers, :img
  end
end
