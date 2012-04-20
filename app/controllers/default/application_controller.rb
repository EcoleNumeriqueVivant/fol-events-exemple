class Default::ApplicationController < ActionController::Base

  def index
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
end
