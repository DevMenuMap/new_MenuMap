class CreateMymaps < ActiveRecord::Migration
  def change
    create_table :mymaps do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :rating
      t.integer :group, default: 0
      t.string :contents

      t.timestamps null: false
    end

		add_index :mymaps, [:user_id, :restaurant_id], unique: true
  end
end
