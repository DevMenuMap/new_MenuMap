require 'csv'

namespace :franchises do
	task :update, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|

			# Default values.
			row[0] = row[0].to_i		# franchise_id

			Franchise.find(row[0]).update(
				name: row[1],
				site: row[2]
			)
		end
	end
end

namespace :restaurants do
	desc "Create a new restaurant"
  task :create, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			
			# Default values.
			row[0] = row[0].to_i		# restaurant_id
			row[8]  ||= false				# delivery
			row[9]  ||= 0						# menu_on
			row[11] ||= true				# active

			@restaurant = Restaurant.create(
				id: row[0],
				category_id: row[2],
				subcategory_id: row[4],
				name: row[5],
				phnum: row[7],
				delivery: row[8],
				menu_on: row[9],
				open_at: row[10],
				active: row[11],
				franchise_id: row[12],
				site: row[13],
				# These two columns are needed only for creation not update.
				addr: row[16],
				addr_code: row[17]
			)

			# Create an associated RestInfo.
			RestInfo.create(
				id: @restaurant.id,
				restaurant_id: @restaurant.id,
				active: true
			)

			# Save a Naver coordinate.
			@restaurant.get_and_save_latlng
		end

		# Same task with addresses:save_addr_tags
		Address.where("id > ?", Addressable::ADDR_TAG).find_each do |a|
			if a.coordinates.present? && a.addr_bounds.present?
				a.save_addr_tags
			end
		end
	end

  desc "Update restaurants' info"
  task :update, [:filename] => :environment do |t, args|

		# Initialzie a log file.
		# logger = Logger.new File.new("log/tasks/rest_update.log", 'w')
		# logger.progname = "restaurant_#{row[0]}"

		# Start the task.
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			
			# Default values.
			row[0] = row[0].to_i		# restaurant_id
			row[8]  ||= false				# delivery
			row[9]  ||= 0						# menu_on
			row[11] ||= true				# active

			Restaurant.unscoped.find(row[0]).update(
				category_id: row[2],
				subcategory_id: row[4],
				name: row[5],
				phnum: row[7],
				delivery: row[8],
				menu_on: row[9],
				open_at: row[10],
				active: row[11],
				franchise_id: row[12],
				site: row[13]
			)
		end
	end
end

namespace :menus do
  desc "Create menus"
  task :create, [:filename] => :environment do |t, args|

		is_franchise  = false 
		franchise_id 	= 0
		restaurant_id = 0
	
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			
			### restaurant_id || franchise_id
			# Check if this row starts with the restaurant_id.
			if row[0]
				# Franchise
				if row[0].to_i > 10**9
					is_franchise = true
					franchise_id = row[0].to_i
				else
					is_franchise 	= false
					restaurant_id = row[0].to_i
				end
			end

			### MenuTitle
			if row[1]
				if is_franchise
					Restaurant.where(franchise_id: franchise_id).each do |r|
						r.menu_titles.create(
							title_name: row[1],
							title_info: row[2]
						)
						r.update(menu_on: 1)
					end
				else
					@restaurant = Restaurant.find(restaurant_id)
					@restaurant.menu_titles.create(
						title_name: row[1],
						title_info: row[2]
					)
					@restaurant.update(menu_on: 1)
				end
			end

			### Menu
			# Default values for menu.
			row[4] = '(' + row[4] + ')' if row[4]		# side_info
			row[5] = row[5].to_i * 100 	if row[5]		# price
			row[7] ||= false												# sitga
			row[8] ||= false												# unidentified

			# If row[3] is blank, menu.name is the same with the last one.
			if !row[3]
				row[3] = if is_franchise
					Restaurant.find_by_franchise_id(franchise_id).menus.last.name
				else
					Restaurant.find(restaurant_id).menus.last.name
				end
			end

			if is_franchise
				Restaurant.where(franchise_id: franchise_id).each do |r|
					r.menu_titles.last.menus.create(
						name: row[3],
						side_info: row[4],
						price: row[5],
						info: row[6],
						sitga: row[7],
						unidentified: row[8],
						active: true,
						best: 0,
						user_id: 10**7
					)
				end
			else
				Restaurant.find(restaurant_id).menu_titles.last.menus.create(
					name: row[3],
					side_info: row[4],
					price: row[5],
					info: row[6],
					sitga: row[7],
					unidentified: row[8],
					active: true,
					best: 0,
					user_id: 10**7
				)
			end
		end
	end
end
