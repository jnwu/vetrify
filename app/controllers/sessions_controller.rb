class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:user_type] == "business_user"
      user = BusinessUser.find_by_email(params[:email])
    else
      user = Profile.find_by_email(params[:email])
    end

    if user && user.authenticate(params[:password])
      session[:user_type] = params[:user_type]
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Welcome back, #{user.name}"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
