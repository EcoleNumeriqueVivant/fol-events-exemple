# coding: utf-8

class UsersController < ApplicationController

  # PUT /users/1
  # PUT /users/1.json
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        format.html { redirect_to :back, notice: 'Vos informations ont été mis à jour.' }
      else
        format.html { render controller: "account", action: "index" }
      end
  end
end