class AddImgToRestRegister < ActiveRecord::Migration
  def up
		add_attachment :rest_registers, :img
  end

	def down
		remove_attachment :rest_registers, :img
	end
end
