class SessionsController < ApplicationController

  before_action :require_logged_out, only: [:new, :create]

  def new 
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy 
    sesh = Session.find_by(session_token: session[:session_token])
    sesh.destroy
    session[:session_token] = nil
    @current_user = nil
    redirect_to cats_url
  end
end