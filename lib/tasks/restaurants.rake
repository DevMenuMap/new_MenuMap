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

	desc 'Ping naver for syndication'
	task :ping, [:start] => :environment do |t, args|
		args.with_default(start: nil)

		# When there is an argument.
		if args.start
			args.start.split.each do |n|
				offset = n.to_i*100
				puts Restaurant.ping(offset)
			end
		# When there was no arguments, ping every restaurants.
		else
			total = Restaurant.count
			total % 100 == 0 ? max = total - 1 : max = total

			0.upto(max).each do |n|
				offset = n*100
				puts Restaurant.ping(offset)
			end
		end
	end
end
