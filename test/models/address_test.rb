require 'test_helper'

class AddressTest < ActiveSupport::TestCase
	def setup
		@address1 = addresses(:address1)
	end

  test "name should be unique" do
		assert_no_difference 'Address.count' do
			@same_name = Address.create(name: "address1")
		end
    assert true
  end
end
