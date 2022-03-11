class TeamsController < ApplicationController
  before_action :set_teams, only: %i[show]
  before_action :set_current_or_favorite_team, only: %i[show], if: :teams?
  before_action :set_organizations, only: %i[show], if: :teams?
  before_action :build_new_calendar, only: %i[show], if: :teams?
  before_action :build_current_user_team, only: %i[new]

  def show
    respond_to do |format|
      if not teams?
        build_current_user_team
        format.html { redirect_to new_team_path }
      elsif not calendars?
        format.html { redirect_to new_team_calendar_path(@current_team) }
      else
        @calendars = @current_team.calendars.includes(:events)
        @new_event = Event.new
        format.html { render 'calendars/index' }
      end
    end
  end

  def new
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.adhesions.new(user_id: current_user.id)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created' }
      else
        format.turbo_stream { render :new, status: :bad_request  }
        format.html { render :new, status: :unprocessable_entity, notice: 'Team cannot be created.' }
      end
    end
  end

  # For development
  def destroy_all
    Team.all.destroy_all
    redirect_to root_path
  end

  private

  def set_teams
    @teams = current_user.teams if current_user
  end

  def build_current_user_team
    @team = current_user.dup.teams.build
  end

  def set_current_or_favorite_team
    @current_team = params&.has_key?(:id) ? Team.includes(calendars: :events).find(params[:id]) : @teams.first
  end

  def build_new_calendar
    @new_calendar = @current_team.dup.calendars.build
  end

  def set_organizations
    @organizations = Organization.select(:name, :id)
  end

  def teams?
    @teams.present?
  end

  def calendars?
    @current_team.calendars.present?
  end

  def team_params
    params.require(:team).permit(:name, :visit_count)
  end
end
