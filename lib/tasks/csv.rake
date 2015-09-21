require 'csv'

namespace :restaurants do
  desc "Update restaurants' info"
  task :update, [:filename] => :environment do |t, args|
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			Restaurant.unscoped.find(row[0].to_i).update(
				category_id: row[1],
				subcategory_id: row[2],
				name: row[3],
				phnum: row[4],
				delivery: row[5],
				menu_on: row[6],
				open_at: row[7],
				active: row[8],
				franchise_id: row[9]
			)
		end
	end
end

namespace :menus do
  desc "Create menus"
  task :create, [:filename] => :environment do |t, args|

		restaurant_id = [0, false]
		franchise_id = 0
	
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			if !row[0].nil?
				if row[0].to_i < 10**9
					restaurant_id = [row[0].to_i, true]
				else
					restaurant_id[1] = false
					franchise_id = row[0].to_i
				end
			end

			if !row[1].nil?
				if restaurant_id[1]
					Restaurant.unscoped.find(restaurant_id[0]).menu_titles.create(
						title_name: row[1],
						title_info: row[2]
					)
				else
					Restaurant.unscoped.where(franchise_id: franchise_id).each do |r|
						r.menu_titles.create(
							title_name: row[1],
							title_info: row[2]
						)
					end
				end
			end

			if restaurant_id[1]
				Restaurant.unscoped.find(restaurant_id[0]).menu_titles.last.menus.create(
					name: row[3],
					side_info: row[4],
					price: row[5],
					info: row[6],
					sitga: row[7],
					unidentified: row[8],
					best: 0,
					user_id: 10**7
				)
			else
				Restaurant.unscoped.where(franchise_id: franchise_id).each do |r|
					r.menu_titles.last.menus.create(
						name: row[3],
						side_info: row[4],
						price: row[5],
						info: row[6],
						sitga: row[7],
						unidentified: row[8],
						best: 0,
						user_id: 10**7
					)
				end
			end
		end
	end
end
