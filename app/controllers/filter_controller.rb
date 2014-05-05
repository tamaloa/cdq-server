class FilterController < ApplicationController

  skip_before_filter :set_return_to

  def set
    filter_params = params.require(:filter)

    session[:resolution] = filter_params.fetch(:resolution) || session[:resolution]
    session[:time_from] = filter_params.fetch(:time_from).values.join('-').to_date || session[:time_from]
    session[:time_till] = filter_params.fetch(:time_till).values.join('-').to_date || session[:time_till]

    flash[:notice] = "Resolution was set to #{session[:resolution]} and time window from #{session[:time_from]} till   #{session[:time_till]}"

    redirect_back_or_default_to_root
  end
end
