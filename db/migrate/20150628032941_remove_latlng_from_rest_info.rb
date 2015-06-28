class RemoveLatlngFromRestInfo < ActiveRecord::Migration
  def change
    remove_column :rest_infos, :naver_lat, :string
    remove_column :rest_infos, :naver_lng, :string
  end
end
