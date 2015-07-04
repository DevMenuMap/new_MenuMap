namespace :restaurants do
  desc "Create rest_infos when there is no associated one for restaurant"
  task :create_rest_infos => :environment do |t, args|
		Restaurant.create_rest_infos
  end

	desc "Save Naver's coordinates for Restaurant"
	task :save_latlngs, [:area] => :environment do |t, args|
		# Set default value to nil on area(params for in_area scope)
		args.with_default(area: nil)

		Restaurant.save_latlngs(args.area)
	end
end
