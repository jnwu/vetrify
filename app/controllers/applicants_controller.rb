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
    @positions  = @applicant.positions.order(ended_at: :desc)
    @educations = @applicant.educations.order(ended_at: :desc)
    @repos      = @applicant.repos.order(updated_at: :desc)
    @timeline   = build_timeline( @educations, @positions, @repos )
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
  def next_year position, education, repo
    possibles = []

    if ( education.present? && education.ended_at.present? )
      possibles << education.ended_at
    end

    if ( repo.present? && repo.updated_at.present? )
      possibles << repo.updated_at.year
    end

    if ( position.present? && position.ended_at.present? )
      possibles << position.ended_at.year
    elsif ( position.present? && position.ended_at.nil? )
      return Time.new.year
    end

    possibles.sort{ |x, y| x <=> y }

    return possibles.last
  end

  def build_timeline educations, positions, repos
    edu_c = 0
    pos_c = 0
    rep_c = 0

    return_value = []
    year_list = []

    current_year = next_year( positions[pos_c], educations[edu_c], repos[rep_c] )

    position  = positions[pos_c]
    education = educations[edu_c]
    repo      = repos[rep_c]

    while ( position.present? || education.present? || repo.present? )
      position  = positions[pos_c]
      education = educations[edu_c]
      repo      = repos[rep_c]

      if ( position.present? && position.ended_at.nil? )
        year_list << [position, "position"]
        pos_c += 1
      elsif ( position.present? && ( position.ended_at.year == current_year ) )
        year_list << [position, "position"]
        pos_c += 1
      elsif ( education.present? && ( education.ended_at == current_year ) )
        year_list << [education, "education"]
        edu_c += 1
      elsif ( repo.present? && ( repo.updated_at.year == current_year ) )
        year_list << [repo, "repo"]
        rep_c += 1
      else
        return_value << [year_list, current_year]
        year_list = []
        current_year = next_year( position, education, repo )
      end
    end

    return_value
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def applicant_params
    params.require(:applicant).permit(:first_name, :last_name, :email, :password, :password, :password_digest)
  end
end
