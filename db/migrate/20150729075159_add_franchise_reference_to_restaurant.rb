class AddFranchiseReferenceToRestaurant < ActiveRecord::Migration
  def change
    add_reference :restaurants, :franchise, index: true, foreign_key: true
  end
end
