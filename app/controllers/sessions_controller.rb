require 'date'

class SessionsController < ApplicationController
  before_action :set_session, only: [:linkedin, :github]

  # GET /sessions/new
  def new
    redirect_to '/auth/linkedin'
  end

  def linkedin        
    begin
      a = SessionsHelper::LinkedInHelper.user @auth[:info]
      session[:user_id] = a.id

      # Update entries for user positions and educations
      SessionsHelper::LinkedInHelper.positions a.id, @auth[:extra][:raw_info][:positions][:values]
      SessionsHelper::LinkedInHelper.educations a.id, @auth[:extra][:raw_info][:educations][:values]
        
      # Update applicant token
      unless a.token
        a.token = Token.create
        a.token.key = SecureRandom.base64
        a.token.key = SecureRandom.base64 while Token.find_by(key: a.token.key) || a.token.key.match(/\+/) || a.token.key.match(/\//)
        a.token.save
      end
    rescue StandardError => e
      SessionsHelper::MandrillHelper.raw 'jack.wu@live.ca', "#{e.message}\n\n#{e.backtrace}\n\n#{@auth[:extra][:raw_info][:positions]}\n\n#{@auth[:extra][:raw_info][:educations]}"
      session[:user_id] = nil
    end

    set_redirect
  end

  def github
    begin 
      a = Applicant.find session[:user_id]
  
      # Update entries applicant repos
      SessionsHelper::GithubHelper.repos(@auth[:credentials][:token], a) { |r|
        SessionsHelper::GithubHelper.languages @auth[:credentials][:token], r
      }

      # Update applicant github url
      if a.github_url.nil? or a.github != @auth[:info][:urls][:GitHub]
        a.github_url = @auth[:info][:urls][:GitHub]
        a.save
      end
    rescue StandardError => e
      SessionsHelper::MandrillHelper.raw 'jack.wu@live.ca', "#{e.message}\n\n#{e.backtrace}"
    end

    set_redirect
  end

private
  def set_session
    @auth = request.env['omniauth.auth']
    redirect_to root_url unless @auth
  end

  def set_redirect
    flash[:id] = session[:user_id] if session[:user_id]
    redirect_to '/applicant' if flash[:id]
    redirect_to root_url unless flash[:id]
  end
end
