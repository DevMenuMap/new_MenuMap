class AddIndexToSlangs < ActiveRecord::Migration
  def change
    add_index :slangs, :name
  end
end
