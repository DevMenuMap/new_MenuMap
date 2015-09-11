class CreateMymapSnapshots < ActiveRecord::Migration
  def change
    create_table :mymap_snapshots do |t|
      t.references :user, index: true, foreign_key: true
      t.attachment :snapshot

      t.timestamps null: false
    end
  end
end
