# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_teams, unless: :api?
  before_action :set_current_or_favorite_team, unless: :api?
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

  def set_teams
    @teams ||= current_user.teams.by_favorite if user_signed_in?
  end

  def set_current_or_favorite_team
    if controller_name == 'teams'
      @current_team ||= params&.key?(:id) ? Team.find(params[:id]) : current_user.favorite_team
    else
      @current_team ||= params&.key?(:team_id) ? Team.find(params[:team_id]) : current_user.favorite_team
    end
  end

  def api?
    controller_path.starts_with? 'api'
  end
end
