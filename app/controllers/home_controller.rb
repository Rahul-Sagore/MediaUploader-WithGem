class HomeController < ApplicationController
	# before_filter :user_logged_in
	before_filter :authenticate_user!
  def index
  	@new_media = Medium.new

  	if current_user.admin?
  		@media = Medium.all
  	else
	  	@user = User.find(current_user.id)
		  @media = @user.mediums
		end
  end

  def upload
  	@media = Medium.new
  	file_obj = params[:new_media][:media_file]

  	if @media.upload_file(file_obj, current_user.id)
  		flash[:success] = "File Successfully uploaded"
  	else
  		@media.errors.each do |key, val|
  			flash[key] = val
  		end
		end

		redirect_to :action => "index"
	end

	def download
		@media = Medium.find_by_id(params[:media])
		begin
			send_file Rails.root.join('public', 'images/uploads/', current_user.id.to_s, @media.filename), :x_sendfile=>true
		rescue
			flash[:error] = "File Not Available to download"
			redirect_to :action => "index"
		end
	end

end
