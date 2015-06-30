class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
