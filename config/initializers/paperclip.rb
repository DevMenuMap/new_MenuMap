# Url options should be string. [':s3_domain_url', ':s3_path_url']
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'

# Save files with :path option.
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:basename.:extension'

# Host name is necessary for non-us accounts.
Paperclip::Attachment.default_options[:s3_host_name] = 's3-ap-southeast-1.amazonaws.com'
