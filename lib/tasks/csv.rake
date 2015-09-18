require 'csv'

namespace :restaurants do
  desc "Update restaurants info"
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
		CSV.foreach('db/seed_data/' + args[:filename] + '.csv', headers: true) do |row|
			if row[0].to_i < 1000000000
				Restaurant.unscoped.find(row[0].to_i).menu_titles[row[1].to_i].menus.create(
					name: row[2],
					side_info: row[3],
					price: row[4],
					info: row[5],
					sitga: row[6],
					unidentified: row[7],
					best: 0,
					user_id: 10**7
				)
			else
				Franchise.find(row[0].to_i).restaurants.each do |r|
					r.menu_titles[row[1].to_i].menus.create(
						name: row[2],
						side_info: row[3],
						price: row[4],
						info: row[5],
						sitga: row[6],
						unidentified: row[7],
						best: 0,
						user_id: 10**7
					)
				end
			end
		end
	end
end
