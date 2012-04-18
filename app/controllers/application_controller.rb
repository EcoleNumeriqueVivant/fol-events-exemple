class ApplicationController < ActionController::Base
  protect_from_forgery
   http_basic_authenticate_with name: "fol", password: "fol"
   
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
   
end
