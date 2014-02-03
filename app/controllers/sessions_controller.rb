require 'date'

class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    redirect_to "/auth/linkedin"
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = Applicant.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_type] = params[:user_type]
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Welcome back, #{user.first_name} #{user.last_name}"
    else
      flash.now.alert = "Invalid email or password"
      render :new
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def auth_callback
    auth = request.env['omniauth.auth']

    if auth[:provider] == 'linkedin'
      a = SessionsHelper::LinkedInHelper.user auth[:info]

      # unless a.token
      #   a.token = Token.create
      #   a.token.key = auth[:extra][:raw_info][:id]
      #   a.token.save
      # end

      # Update entries for user positions and educations
      SessionsHelper::LinkedInHelper.positions a.id, auth[:extra][:raw_info][:positions][:values]
      SessionsHelper::LinkedInHelper.educations a.id, auth[:extra][:raw_info][:educations][:values]

      session[:user_id] = a.id
    elsif auth[:provider] == 'github'
      a = Applicant.find_by id: session[:user_id]

      if a.github_url.nil? or a.github != auth[:info][:urls][:GitHub]
        a.github_url = auth[:info][:urls][:GitHub]
        a.save
      end

      SessionsHelper::GithubHelper.repos(auth[:credentials][:token], a) { |r|
        SessionsHelper::GithubHelper.languages auth[:credentials][:token], r
      }
    end

    flash[:id] = session[:user_id]
    redirect_to '/applicant', :notice => "Authenticated successfully"
  end
end
