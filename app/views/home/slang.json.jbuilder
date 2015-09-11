if @result.blank?
	json.slang @result
else
	json.slang @result.first.name
end
json.status @result.present?
