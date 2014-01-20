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

      auth[:extra][:raw_info][:positions][:values].each do |position|
        b = Business.find_or_create_by(name: position[:company][:name])
        p = Position.find_by(applicant_id: a.id, business_id: b.id, name: position[:title])       
        p = Position.create(
            applicant_id: a.id,
            business_id:  b.id,
            name:         position[:title],
            summary:      position[:summary],
            started_at:   Date.new(position[:startDate][:year], position[:startDate][:month]),
            ended_at:     (position[:endDate] ? Date.new(position[:endDate][:year], position[:endDate][:month]) : nil)
        ) unless p

        if p.summary != position[:summary] 
          Position.update(
            p.id,
            :summary  =>  position[:summary],
            :ended_at =>  (position[:endDate] ? Date.new(position[:endDate][:year], position[:endDate][:month]) : nil)
          )
        end
      end

      SessionsHelper::LinkedInHelper.educations a, auth[:extra][:raw_info][:educations][:values]
      session[:user_id] = a.id
    elsif auth[:provider] == 'github'
      repos = SessionsHelper::GithubHelper.repos auth[:credentials][:token]
      repos.each do |repo|
        repo.symbolize_keys!

        r = Repo.find_by(name: repo[:name])
        r = Repo.create(          
          applicant_id: session[:user_id],
          name:         repo[:name], 
          url:          repo[:html_url],
          started_at:   Date.parse(repo[:created_at]),
          updated_at:   Date.parse(repo[:updated_at])
        ) unless r       

        total = 0
        languages = SessionsHelper::GithubHelper.languages auth[:credentials][:token], repo[:full_name]
        languages.symbolize_keys!
        languages.keys.each do |key|
          total += languages[key].to_i
        end

        languages.keys.each do |key|
          s = Skill.find_or_create_by name: key
          Language.find_by(repo_id: r.id, skill_id: s.id) or
            Language.create(
              repo_id:  r.id, 
              skill_id: s.id,
              percent:  ((languages[key].to_f / total) * 100).round(2)
            )
        end
      end
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
