class SubjectiveAssessmentsController < ApplicationController
  before_action :set_subjective_assessment, only: [:show, :edit, :update, :destroy]

  # GET /subjective_assessments
  # GET /subjective_assessments.json
  def index
    @subjective_assessments = SubjectiveAssessment.all
  end

  # GET /subjective_assessments/1
  # GET /subjective_assessments/1.json
  def show
  end

  # GET /subjective_assessments/new
  def new
    @subjective_assessment = SubjectiveAssessment.new(subjective_assessment_params)
  end
  # def new
  #   session[:subjective_assessment_params] ||= {app_id: params[:subjective_assessment][:app_id]}
  #   @subjective_assessment = SubjectiveAssessment.new(session[:subjective_assessment_params])
  #   @subjective_assessment.current_step = session[:subjective_assessment_step]
  # end

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
    respond_to do |format|
      if @subjective_assessment.update(subjective_assessment_params)
        format.html { redirect_to @subjective_assessment, notice: 'Subjective assessment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @subjective_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjective_assessments/1
  # DELETE /subjective_assessments/1.json
  def destroy
    @subjective_assessment.destroy
    respond_to do |format|
      format.html { redirect_to subjective_assessments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subjective_assessment
      @subjective_assessment = SubjectiveAssessment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subjective_assessment_params
      params.require(:subjective_assessment).permit(:app_id, :dimensions)
    end
end
