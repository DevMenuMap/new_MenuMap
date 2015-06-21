module ImagesHelper
	# Model specific image_tag
	def custom_image_tag(instance, picture)
		image_tag picture.img.url, alt: "#{image_tag_alt(instance)}"
	end

	# Get method name for printing instance's alt attribute
	def image_tag_alt(instance)
		send(instance.class.to_s.underscore + "_alt_attribute", instance)
	end

	def rest_register_alt_attribute(instance)
		"음식점 사진 - #{instance.name}, 분류: #{instance.subcategory}, 지역: #{instance.addr}"
	end
end
