require 'csv'

namespace :categories do
  task :create => :environment do
		CSV.foreach('db/seed_data/categories.csv', headers: true) do |row|
			Category.create(
				id: row[0],
				name: row[1]
			)
		end
  end
end

namespace :subcategories do
  task :create => :environment do
		CSV.foreach('db/seed_data/subcategories.csv', headers: true) do |row|
			Subcategory.create(
				# wrong order from csv file
				id: row[1],
				name: row[0]
			)
		end
  end
end

namespace :category_relationships do
  task :create => :environment do
		CSV.foreach('db/seed_data/category_relationships.csv', headers: true) do |row|
			CategoryRelationship.create(
				category_id: row[0],
				subcategory_id: row[1]
			)
		end
  end
end

namespace :addresses do
  task :create => :environment do
		CSV.foreach('db/seed_data/addresses.csv', headers: true) do |row|
			Address.create(
				id: row[0],
				name: row[1]
			)
		end
  end
end

namespace :addr_conversions do
  task :create => :environment do
		CSV.foreach('db/seed_data/addr_conversions.csv', headers: true) do |row|
			AddrConversion.create(
				address_id: row[0],
				convert_to: row[1],
				convert_from: row[2]
			)
		end
  end
end

namespace :restaurants do
  task :create => :environment do
		CSV.foreach('db/seed_data/restaurants.csv', headers: true) do |row|
			Restaurant.create(
				id: row[0],
				name: row[1],
				category_id: row[2],
				subcategory_id: row[3],
				addr: row[4],
				phnum: row[5],
				delivery: row[6],
				menu_on: row[7],
				open_at: row[8],
				active: row[9]
			)
		end
  end
end

namespace :menu_titls do
  task :create => :environment do
		CSV.foreach('db/seed_data/menu_titles.csv', headers: true) do |row|
			MenuTitle.create(
				id: row[0],
				restaurant_id: row[1],
				title_name: row[2],
				title_info: row[3]
			)
		end
  end
end

namespace :rest_errs do
  task :create => :environment do
		CSV.foreach('db/seed_data/rest_errs.csv', headers: true) do |row|
			RestErr.create(
				restaurant_id: row[0],
				presence_err: row[1],
				menu_err: row[2],
				phnum_err: row[3],
				category_err: row[4],
				etc: row[5]
			)
		end
  end
end

namespace :franchises do
	task :create => :environment do
		CSV.foreach('db/seed_data/rest_fran.csv', headers: true) do |row|
		
			a = Restaurant.unscoped.find(row[0].to_i)
			a.franchise = Franchise.find(row[1].to_i)
			a.save
		end
	end
end
