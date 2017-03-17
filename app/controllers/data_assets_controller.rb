class DataAssetsController < ApplicationController
  before_action :set_data_asset, only: [:show]

  # GET /data_assets
  # GET /data_assets.json
  def index
    @data_assets = DataAsset.all
  end

  # GET /data_assets/1
  # GET /data_assets/1.json
  def show
    @dimension = @data_asset
    render 'dimensions/show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_asset
      @data_asset = DataAsset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_asset_params
      params.require(:data_asset).permit(:name, :description, :app_id)
    end
end
