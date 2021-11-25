class ApplicationController < ActionController::Base
  before_action :authenticate_administrator!

  def page_unauthorized
    if administrator_signed_in?
      redirect_to login_redirect_path
    else
      render file: 'public/401.html', status: :unauthorized
    end
  end

  private

  def login_redirect_path
    stored_location_for(:administrator) || root_path
  end
end
