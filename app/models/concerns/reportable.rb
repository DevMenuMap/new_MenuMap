module Reportable
	# Check how many success and failures were there and their ids
	def report_results(success_num, failure_array)
		puts "#{success_num} successes | #{failure_array.length} failures"
		if !failure_array.blank?
			puts "***** failed "
			puts failure_array.inspect
		end
	end
end
