class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_filter :initialize_session_filter, except: [:new, :create, :update]
  before_filter :set_return_to

  private


  def initialize_session_filter
    session[:resolution] =  session[:resolution] || 'week'
    session[:time_from] = session[:time_from] || Time.now-1.year
    session[:time_till] = session[:time_till] || Time.now
    @filter = {:resolution => session[:resolution],
              :time_till => session[:time_till],
              :time_from => session[:time_from]}
  end

  def redirect_back_or_default_to_root
    redirect_to(session[:return_to] || :root)
    session.delete(:return_to)
  end

  def set_return_to
    session[:return_to] = request.fullpath
  end
end
