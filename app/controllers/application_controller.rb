class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites

  def favorites
    @favorites ||= Favorite.new(session[:favorites])
  end
end
