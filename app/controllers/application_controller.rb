class ApplicationController < ActionController::Base
  protect_from_forgery
   
   #http_basic_authenticate_with name: "fol", password: "fol"
   
   # require File.expand_path(File.dirname(__FILE__)) + 
   # require "./MailChimp.rb"
   
   def add_to_list
     puts params.inspect
     if session[:register].nil?
       # MailChimp.subscribe params[:mail]
       session[:register] = params[:mail]
     end
     render :nothing => true, :status => 200
   end 
   
   def dashboard 
   end   
   
   helper_method :current_user

   private

   def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
   
   
end
