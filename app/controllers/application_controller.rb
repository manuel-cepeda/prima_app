class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Mobylette::RespondToMobileRequests
  include SessionsHelper

	mobylette_config do |config|
	  config[:skip_xhr_requests] = false
	end

end
