class ApplicationController < ActionController::Base
  before_action :set_theme

  private

  def set_theme
    theme = params[:theme]
    return unless theme

    cookies[:theme] = theme.to_sym
    redirect_back(fallback_location: root_path)
  end
end
