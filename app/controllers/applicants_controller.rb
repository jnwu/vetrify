class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [:show, :edit, :update, :destroy]

  # GET /applicants
  # GET /applicants.json
  def index
    @applicants = Applicant.all
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    @education  = @applicant.educations.first
    positions  = @applicant.positions.order(ended_at: :desc)
    educations = @applicant.educations.order(ended_at: :desc)

    length = (positions.length + educations.length)
    edu_count = 0
    pos_count = 0

    @timeline = []
    for i in 0..length
      if ( educations[edu_count].present? && positions[pos_count].present? )

        if ( positions[pos_count].ended_at.nil? ||
             positions[pos_count].ended_at.year > educations[edu_count].ended_at )
          @timeline << [ positions[pos_count], "position" ]
          pos_count += 1
        else
          @timeline << [ educations[edu_count], "education"]
          edu_count += 1
        end

      elsif ( positions[pos_count].present? )
        @timeline << [ positions[pos_count], "position" ]
        pos_count += 1
      elsif ( educations[edu_count].present? )
        @timeline << [ educations[edu_count], "education"]
        edu_count += 1
      end
    end
  end

  # GET /applicants/new
  def new
    # see sessions auth callback
  end

  # GET /applicants/1/edit
  def edit
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(applicant_params)

    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @applicant }
      else
        format.html { render action: 'new' }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    respond_to do |format|
      if @applicant.update(applicant_params)
        format.html { redirect_to @applicant, notice: 'Applicant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @applicant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @applicant.destroy
    respond_to do |format|
      format.html { redirect_to applicants_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def applicant_params
      params.require(:applicant).permit(:first_name, :last_name, :email, :password, :password, :password_digest)
    end
end
