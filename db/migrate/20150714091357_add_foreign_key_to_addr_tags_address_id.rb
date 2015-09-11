class AddForeignKeyToAddrTagsAddressId < ActiveRecord::Migration
  def change
		add_foreign_key :addr_tags, :addresses
  end
end
