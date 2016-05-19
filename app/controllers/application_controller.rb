class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user 

  def user_logged_in
		if session[:user_id].nil?
			redirect_to_login
		end
		user_exist = current_user

		if user_exist.nil?
			session[:user_id] = nil
		else
			user_exist
		end
	end

	def current_user
	  @current_user ||= User.find(session[:user_id]) if !session[:user_id].nil?
	  rescue ActiveRecord::RecordNotFound
	end

	def redirect_to_login
		redirect_to "/login"
	end
end
