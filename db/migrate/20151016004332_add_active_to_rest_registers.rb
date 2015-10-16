class AddActiveToRestRegisters < ActiveRecord::Migration
  def change
		add_column :rest_registers, :active, :boolean, default: true
  end
end
