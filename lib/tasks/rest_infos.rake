namespace :rest_infos do
	desc "Save Google's coordinates for RestInfo"
	task :save_latlngs, [:area] => :environment do |t, args|
		# Make a file named like migration file's timestamp and write logs
		# to that file
		new_file = "#{Time.now.strftime("%Y%m%d%H%M%S")}" + "_latlng_parsing_google.txt"
		file_path = File.join(Rails.root, 'log', 'tasks', 'latlng_parsing', new_file)

		File.open(file_path, 'w+') do |f|
			# Set default value to nil on area(params for in_area scope)
			args.with_default(area: nil)
			
			# Puts area where speicfied with rake task["somewhere"]
			f.puts "In this area: " + args.area
			RestInfo.save_latlngs(args.area, f)
		end
	end
end
