# coding: utf-8

class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :controller => "application", :action => "dashboard", :notice => "Logged in!"
    else
      flash.now.alert = "email ou mot de passe invalide"
      render [:default, :root]
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Vous êtes déconnecté"
  end

end
