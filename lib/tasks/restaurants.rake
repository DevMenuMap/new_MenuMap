namespace :restaurants do
  desc "Create rest_infos when there is no associated one for restaurant"
  task :create_rest_infos => :environment do
		# Make a file named like migration file's timestamp and write logs
		# to that file
		new_file = "#{Time.now.strftime("%Y%m%d%H%M%S")}" + "_create_rest_infos.txt"
		file_path = File.join(Rails.root, 'log', 'tasks', 'rest_infos', new_file)

		File.open(file_path, 'w+') do |f|
			Restaurant.create_rest_infos(f)
		end
  end

	desc "Save Naver's coordinates for Restaurant"
	task :save_latlngs, [:area] => :environment do |t, args|
		# Make a file named like migration file's timestamp and write logs
		# to that file
		new_file = "#{Time.now.strftime("%Y%m%d%H%M%S")}" + "_latlng_parsing_naver.txt"
		file_path = File.join(Rails.root, 'log', 'tasks', 'latlng_parsing', new_file)

		File.open(file_path, 'w+') do |f|
			# Set default value to nil on area(params for in_area scope)
			args.with_default(area: nil)

			# Puts area where speicfied with rake task["somewhere"]
			f.puts "In this area: " + args.area
			Restaurant.save_latlngs(args.area, f)
		end
	end

	desc 'Ping naver for seo'
	task :ping => :environment do
		puts Restaurant.ping
	end
end
