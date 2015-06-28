class Address < ActiveRecord::Base
	### Associations
	has_many :coordinates, as: :latlng
	has_many :addr_conversions

	# Associated attributes
	accepts_nested_attributes_for :coordinates


	### Validations
	validates :name, presence: true, uniqueness: true


	### Class methods
	# Return Address for AddrTag
	def Address.addr_tag_category
		where("MOD(id, 1000000000) = ? AND id > ?", 0, 100000000000)
	end


	### Instance methods
	# 광역지방자치단체(1), 기초지방자치단체(2), 법정동(3), 행정동(4)
	# Administritive district factor
	def admin_addr_factor(n)
		10**(12 - 3 * n)
	end

	# Maximum value for admin_addr
	def admin_addr_max(n)
		self.id + admin_addr_factor(n)
	end

	# 중분류(1), 소분류(2), data(3)
	# AddrTag factor
	def addr_tag_factor(n)
		10**(11 - 2 * n)
	end 

	# Maximum value for addr_tag
	def addr_tag_max(n)
		self.id + addr_tag_factor(n)
	end

	# Address for administrative districts
	# 기초지방자치단체(1), 법정동(2), 행정동(3)
	def admin_addr(n)
		if n != 3 
			Address.where("id > ? AND id < ? AND MOD(id, ?) = 0", self.id, self.admin_addr_max(n), admin_addr_factor(n + 1))
		else
			Address.where("id > ? AND id < ?", self.id, self.admin_addr_max(3))
		end
	end

	# Address for AddrTag
	# 중분류(1), 소분류(2), data(3)
	def addr_tag(n)
		if n != 3
			Address.where("id > ? AND id < ? AND MOD(id, ?) = 0", self.id, self.addr_tag_max(n), addr_tag_factor(n + 1))
		else
			Address.where("id > ? AND id < ?", self.id, self.addr_tag_max(3))
		end	
	end
end
