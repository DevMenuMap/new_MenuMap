class CreateUserVoices < ActiveRecord::Migration
  def change
    create_table :user_voices do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
