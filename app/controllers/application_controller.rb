class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?

  def page_unauthorized
    if user_signed_in?
      redirect_to login_redirect_path
    else
      render file: 'public/401.html', status: :unauthorized
    end
  end

  private

  def login_redirect_path
    stored_location_for(:user) || root_path
  end
end
