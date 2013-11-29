class DimensionsController < ApplicationController
  before_action :set_dimension, only: [:show, :edit, :update, :destroy]

  # GET /dimensions
  # GET /dimensions.json
  def index
    @dimensions = Dimension.all
  end

  # GET /dimensions/1
  # GET /dimensions/1.json
  def show
  end

  # POST /dimensions
  # POST /dimensions.json
  def create
    @dimension = Dimension.find_by_name(dimension_params.fetch(:name)) || Dimension.new(dimension_params)

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to @dimension, notice: 'Dimension was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dimension }
      else
        format.html { render action: 'new' }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dimensions/1
  # PATCH/PUT /dimensions/1.json
  def update
    respond_to do |format|
      if @dimension.update(dimension_params)
        format.html { redirect_to @dimension, notice: 'Dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dimensions/1
  # DELETE /dimensions/1.json
  def destroy
    @dimension.destroy
    respond_to do |format|
      format.html { redirect_to dimensions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dimension
      @dimension = Dimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dimension_params
      params.require(:dimension).permit(:name, :description, :expectation, :weight, :app_id)
    end
end
