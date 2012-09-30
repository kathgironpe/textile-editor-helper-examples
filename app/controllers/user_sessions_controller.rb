class UserSessionsController < ApplicationController

  respond_to :html
  before_filter :authenticate_user, :only => [:create]

  def new
    @user = User.new
  end

  def create
    if @user
      redirect_to root_url
    else
      @user = User.new
      render action: "new"
    end
  end

  def destroy
    logout
    flash[:notice] = "Logged out!"
    redirect_to root_url
  end

  private

  def authenticate_user
    @user = login(params[:user][:username], params[:user][:password])
  end

end
