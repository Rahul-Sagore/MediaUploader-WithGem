class HomeController < ApplicationController
	before_filter :user_logged_in
  def index
  	@new_media = Medium.new

  	if @current_user[:role] == 'admin'
  		@media = Medium.all
  	else
	  	@user = User.where(:id => session[:user_id]).first
	  	if @user.nil?
	  		session[:user_id] = nil
	  		redirect_to "/login"
	 		end	
	  	@media = @user.mediums
	  end
  end

  def upload
	  if params[:new_media]
	  	fileObj = params[:new_media][:media_file]     

		 	if fileObj
		 		# Save the file info into database
		 		@create_media = Medium.new
		 		@create_media[:user_id] = session[:user_id]
		 		@create_media[:filename] = fileObj.original_filename

		 		File.open(Rails.root.join('public', 'images/uploads/', session[:user_id].to_s, fileObj.original_filename), 'w') do |file|
		 			@create_media[:media_file] = file
		 		end
        @create_media.save!
	    end
	  else
	  	flash[:error] = "Please select file to upload"
		end

		redirect_to :action => "index"
	end

end
