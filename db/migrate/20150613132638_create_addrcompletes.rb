class CreateAddrcompletes < ActiveRecord::Migration
  def change
    create_table :addrcompletes do |t|
      t.string :name

      t.timestamps null: false
    end

		add_index :addrcompletes, :name, unique: true
  end
end
