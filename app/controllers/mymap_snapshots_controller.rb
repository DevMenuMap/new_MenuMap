class MymapSnapshotsController < ApplicationController
	def new
		@user = User.find(params[:user_id])		
		respond_to do |format|
			format.js
		end
	end
end
