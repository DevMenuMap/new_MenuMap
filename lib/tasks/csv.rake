require 'csv'

namespace :csv do
  desc "Import csv file to database"
  task :import => :environment do
		CSV.foreach('db/seed_data/address_conversions.csv', headers: true) do |row|
			AddrConversion.create(
				name: row[0],
				id: row[1]
			)
		end
  end
end
