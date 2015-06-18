class CreateRestInfos < ActiveRecord::Migration
  def change
    create_table :rest_infos do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.text :owner_intro
      t.decimal :naver_lat, precision: 11, scale: 8
      t.decimal :naver_lng, precision: 11, scale: 8
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
