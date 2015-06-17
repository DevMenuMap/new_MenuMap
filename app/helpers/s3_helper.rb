module S3Helper
	# Return url of image file on AWS S3
	def s3_image_url(file_name)
		"http://menumap-s3-development.s3-ap-southeast-1.amazonaws.com/static_assets/images/" + file_name
	end
end
