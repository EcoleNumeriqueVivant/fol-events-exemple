class ApplicationController < ActionController::Base
  protect_from_forgery
   
   helper_method :current_user, :check_user
   # before_filter :check_user
   
   # require File.expand_path(File.dirname(__FILE__)) + 
   # require "./MailChimp.rb"
   
   def add_to_list
     puts params.inspect
     if session[:register].nil?
       MailChimp.subscribe params[:mail]
       session[:register] = params[:mail]
     end
     render :nothing => true, :status => 200
   end 
   
   def dashboard 
   end
   
   def check_user
       if current_user.blank?
         respond_to do |format|
           format.html do
              redirect_to root_path 
           end
         end
       end 
   end

   private

   def current_user
     @current_user ||= User.find(session[:user_id]) if session[:user_id]
   end
       
end
