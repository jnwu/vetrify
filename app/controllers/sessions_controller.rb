class SessionsController < ApplicationController
  before_action :set_session, only: [:create, :destroy]

  # GET /sessions/new
  def new
  end

  # POST /sessions
  # POST /sessions.json
  def create
    if params[:user_type] == "business_user"
      user = BusinessUser.find_by_email(params[:email])
    elsif params[:user_type] == "applicant"
      user = Applicant.find_by_email(params[:email])
    end

    if user && user.authenticate(params[:password])
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
    auth_hash = request.env['omniauth.auth']

    puts "auth_hash: #{auth_hash.inspect}"
    redirect_to root_url, :notice => "Authenticated successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
    end  
end
