class BusinessUserController < ApplicationController
  before_action :set_business_user, only: [:show, :edit, :update, :destroy]

  # GET /business_user
  # GET /business_user.json
  def index
    @user = BusinessUser.all
  end

  # GET /business_user/1
  # GET /business_user/1.json
  def show
  end

  # GET /business_user/new
  def new
    @user = BusinessUser.new
  end

  # GET /business_user/1/edit
  def edit
  end

  # POST /business_user
  # POST /business_user.json
  def create
    @user = BusinessUser.new(business_user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'business_user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_user/1
  # PATCH/PUT /business_user/1.json
  def update
    respond_to do |format|
      if @user.update(business_user_params)
        format.html { redirect_to @user, notice: 'business_user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_user/1
  # DELETE /business_user/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to business_user_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_user
      @user = Business_user.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_user_params
      params.require(:business_user).permit(:name, :company_type, :business_user_type, :founded_year, :status, :location, :size, :stock_exchange, :ticker, :specialties, :culture, :domain, :url, :twitter, :facebook, :linkedin)
    end
end
