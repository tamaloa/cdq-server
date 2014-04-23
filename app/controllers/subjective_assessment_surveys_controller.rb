class SubjectiveAssessmentSurveysController < ApplicationController
  before_action :set_subjective_assessment, only: [:show, :edit, :update, :destroy]

  # GET /subjective_assessments
  # GET /subjective_assessments.json
  def index
    @subjective_assessment_surveys = SubjectiveAssessmentSurvey.all
  end

  # GET /subjective_assessments/1
  # GET /subjective_assessments/1.json
  def show
  end

  # GET /subjective_assessments/new
  def new
    @subjective_assessment_survey = SubjectiveAssessmentSurvey.create(subjective_assessment_params)
  end

  # GET /subjective_assessments/1/edit
  def edit
  end

  # POST /subjective_assessments
  # POST /subjective_assessments.json
  def create

  end

  # PATCH/PUT /subjective_assessments/1
  # PATCH/PUT /subjective_assessments/1.json
  def update
     update_successful = @subjective_assessment_survey.update(subjective_assessment_params)
    respond_to do |format|
      if update_successful && SubjectiveAssessmentCycle.new(@subjective_assessment_survey).run
        format.html { redirect_to @subjective_assessment_survey, notice: 'Subjective assessment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subjective_assessment_survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjective_assessments/1
  # DELETE /subjective_assessments/1.json
  def destroy
    @subjective_assessment_survey.destroy
    respond_to do |format|
      format.html { redirect_to subjective_assessments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subjective_assessment
      @subjective_assessment_survey = SubjectiveAssessmentSurvey.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subjective_assessment_params
      params.require(:subjective_assessment_survey).permit! #FIXME narrow down allowed params
    end
end
