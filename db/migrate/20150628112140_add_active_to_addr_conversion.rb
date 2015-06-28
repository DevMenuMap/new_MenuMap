class AddActiveToAddrConversion < ActiveRecord::Migration
  def change
    add_column :addr_conversions, :active, :boolean, default: true
  end
end
