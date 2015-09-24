json.status @result.present?
if @result.nil?
	json.slang nil
else
	json.slang @result.name
end
