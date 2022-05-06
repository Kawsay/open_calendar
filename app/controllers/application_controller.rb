# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :set_teams, unless: :api?
  before_action :set_current_or_favorite_team, unless: :api?
  after_action :verify_authorized, unless: :devise_controller?
  around_action :switch_locale

  def set_teams
    @teams ||= current_user.teams.by_favorite if user_signed_in?
  end

  def set_current_or_favorite_team
    if user_signed_in? && controller_name == 'teams'
      @current_team ||= params&.key?(:id) ? Team.find(params[:id]) : current_user.favorite_team
    elsif user_signed_in?
      @current_team ||= params&.key?(:team_id) ? Team.find(params[:team_id]) : current_user.favorite_team
    end
  end

  def api?
    controller_path.starts_with? 'api'
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def pundit_user
    UserContext.new(current_user, session)
  end
end
