module Addressable
	### Constants
	ADDR_TAG	 = 10**11
	ADMIN_SI	 = 10**9
	ADMIN_GU	 = 10**7
	LEGAL_DONG = 10**3


	# Check if address is address taggable not district.
	# n is address_id
	def addr_taggable?(n)
		n > ADDR_TAG
	end

	# Convert address_id into address range hash. { key: { :min, :max } }
	# except addr_tag which only has address_id itself.
	def get_addr_range_hash(n)
		addr_range_hash = {}
		
		if n > ADDR_TAG
			addr_range_hash[:addr_tag] = n
		elsif n % ADMIN_SI == 0
			addr_range_hash[:si] = { min: n, max: n + ADMIN_SI }
		elsif n % ADMIN_GU == 0
			addr_range_hash[:gu] = { min: n, max: n + ADMIN_GU }
		else
			# Divider for not subordinate dongs.
			divider = divider_for_non_subordinate_dong(n)
			divider == LEGAL_DONG * 10 ? key = :legal_dong : key = :admin_dong
			# When it is not subordinate dong. e.g. 신림동(o), 신림3동(x)
			if id % divider == 0
				addr_range_hash[key] = { min: id, max: id + divider }
			# When it is subordinate dong. e.g. 대치2동, 개포1동
			else							 
				addr_range_hash[key] = { min: id, max: id + ( divider / 10 ) }
			end
		end
	end

	# Return divider which can determine if the dong is subordinate or not.
	def divider_for_non_subordinate_dong(n)
		if n % LEGAL_DONG == 0	# :legal_dong
			LEGAL_DONG * 10
		else										# :admin_dong
			10
		end
	end
end
