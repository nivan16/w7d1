class SessionsController < ApplicationController
  def new 
    @user = User.new
    redirect_to users_url
  end

  def create

  end

  def destroy 

  end
end