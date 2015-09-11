class AddPriorityToAddrcompletes < ActiveRecord::Migration
  def change
    add_column :addrcompletes, :priority, :integer
  end
end
