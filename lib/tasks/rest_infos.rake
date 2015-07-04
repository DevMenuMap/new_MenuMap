namespace :rest_infos do
	desc "Save Google's coordinates for RestInfo"
	task :save_latlngs, [:area] => :environment do |t, args|
		# Set default value to nil on area(params for in_area scope)
		args.with_default(area: nil)
		
		RestInfo.save_latlngs(args.area)
	end
end
