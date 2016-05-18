class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user 

  def user_logged_in
		if session[:user_id].nil?
			redirect_to "/login"
		end
		current_user
	end

	def current_user
	  @current_user ||= User.find(session[:user_id]) if !session[:user_id].nil?
	end
end
