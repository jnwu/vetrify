require 'date'

class SessionsController < ApplicationController
  before_action :set_session, only: [:create, :destroy]

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
      a = Applicant.find_or_create_by(
        email:      auth[:info][:email],
        first_name: auth[:info][:first_name],
        last_name:  auth[:info][:last_name],
        image:      auth[:info][:image]
      )

      # Update entries for user positions and educations
      SessionsHelper::LinkedInHelper.positions a.id, auth[:extra][:raw_info][:positions][:values]
      SessionsHelper::LinkedInHelper.educations a.id, auth[:extra][:raw_info][:educations][:values]

      session[:user_id] = a.id
    elsif auth[:provider] == 'github'
      SessionsHelper::GithubHelper.repos(auth[:credentials][:token], session[:user_id]) { |r|
        SessionsHelper::GithubHelper.languages auth[:credentials][:token], r
      }
    end

    redirect_to applicant_path(session[:user_id]), :notice => "Authenticated successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
    end
end
