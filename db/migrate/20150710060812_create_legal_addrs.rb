class CreateLegalAddrs < ActiveRecord::Migration
  def change
    create_table :legal_addrs do |t|
      t.string :gu
      t.string :dong
      t.boolean :mt, default: false
      t.string :jibun

      t.timestamps null: false
    end
  end
end
