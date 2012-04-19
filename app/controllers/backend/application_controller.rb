class Backend::ApplicationController < ActionController::Base
  
  http_basic_authenticate_with name: "fol", password: "fol"
  
  def index
  end
    
end
