class SessionsController < ApplicationController

  def new
  end

  def create
    if params[:user_tyoe] == "business_user"
      user = BusinessUser.find_by_email(params[:email])
    else
      user = Profile.find_by_email(params[:email])
    end

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_root_path, :notice => "Welcome back, #{user.name}"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

private

  def try_auth user

  end

end
