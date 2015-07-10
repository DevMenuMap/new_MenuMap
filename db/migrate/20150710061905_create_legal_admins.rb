class CreateLegalAdmins < ActiveRecord::Migration
  def change
    create_table :legal_admins do |t|
      t.references :legal_addr, index: true, foreign_key: true
      t.references :admin_addr, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
