namespace :database do
  desc "Convert first part of addr_tag's name with second part of it"
  task convert_addr_tag_name: :environment do
		Address.where("id > ? AND id < ? AND MOD(id, ?) != 0", 104*(10**9), 105*(10**9), 10**5).each do |a|
			first = a.name.split(/\s-\s/)[0]
			second = a.name.split(/\s-\s/)[1]
			a.update(name: second + ' - ' + first)
		end
  end
end
