class BusinessUsersController < ApplicationController
  before_action :set_business_user, only: [:show, :edit, :update, :destroy]

  # GET /business_users
  # GET /business_users.json
  def index
    @business_users = BusinessUser.all
  end

  # GET /business_users/1
  # GET /business_users/1.json
  def show
  end

  # GET /business_users/new
  def new
    @business_user = BusinessUser.new
  end

  # GET /business_users/1/edit
  def edit
  end

  # POST /business_users
  # POST /business_users.json
  def create
    @business_user = BusinessUser.new(business_user_params)

    respond_to do |format|
      if @business_user.save
        format.html { redirect_to @business_user, notice: 'Business user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @business_user }
      else
        format.html { render action: 'new' }
        format.json { render json: @business_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_users/1
  # PATCH/PUT /business_users/1.json
  def update
    respond_to do |format|
      if @business_user.update(business_user_params)
        format.html { redirect_to @business_user, notice: 'Business user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @business_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_users/1
  # DELETE /business_users/1.json
  def destroy
    @business_user.destroy
    respond_to do |format|
      format.html { redirect_to business_users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_user
      @business_user = BusinessUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_user_params
      params.require(:business_user).permit(:business_id, :email, :first_name, :last_name, :title, :password, :password_digest)
    end
end
