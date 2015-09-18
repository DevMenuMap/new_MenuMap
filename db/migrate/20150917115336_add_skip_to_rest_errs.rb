class AddSkipToRestErrs < ActiveRecord::Migration
  def change
    add_column :rest_errs, :skip, :boolean, default: false
  end
end
