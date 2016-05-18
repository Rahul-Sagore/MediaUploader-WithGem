class HomeController < ApplicationController
	before_filter :user_logged_in
  def index
  	@new_media = Medium.new

  	if @current_user[:role] == 'admin'
  		@media = Medium.all
  	else
	  	@user = User.find(session[:user_id])
	  	@media = @user.mediums
	  end
  end

  def upload
	  if params[:new_media]
	  	fileObj = params[:new_media][:name]     

		 	if fileObj
		 		# Write the uploaded file
		 		File.open(Rails.root.join('public', 'images/uploads/', session[:user_id].to_s, fileObj.original_filename), 'w') do |file|
		      file.write(fileObj.read)
		    end 

		    # Save the file info into database
		 		@create_media = Medium.new(params[:new_media])
        @create_media[:user_id] = session[:user_id]
        @create_media[:filename] = fileObj.original_filename
        @create_media[:mime_type] = fileObj.content_type

        @create_media.save
	    end
	  else
	  	flash[:error] = "Please select file to upload"
		end

		redirect_to :action => "index"
	end

end
