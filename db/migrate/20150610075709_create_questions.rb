class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :email
      t.text :contents

      t.timestamps null: false
    end
  end
end
