class Default::ApplicationController < ActionController::Base

  def index
    @user = User.new
  end

end
