class CreateAdminAddrs < ActiveRecord::Migration
  def change
    create_table :admin_addrs do |t|
      t.string :gu
      t.string :dong

      t.timestamps null: false
    end
  end
end
