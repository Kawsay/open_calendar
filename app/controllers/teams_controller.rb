# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_organizations, only: %i[show], if: :teams?
  before_action :build_new_calendar, only: %i[show], if: :teams?
  before_action :build_current_user_team, only: %i[new]

  def show
    respond_to do |format|
      if !teams?
        authorize Team
        build_current_user_team
        format.html { redirect_to new_team_path }
      elsif !calendars?
        format.html { redirect_to new_team_calendar_path(authorize(@current_team)) }
      else
        format.html { redirect_to team_calendars_path(authorize(@current_team)) }
      end
    end
  end

  def new
    authorize @team
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.adhesions.new(user_id: current_user.id)

    authorize @team

    respond_to do |format|
      if @team.save
        authorize @team
        format.html { redirect_to @team, notice: 'Team was successfully created' }
      else
        format.turbo_stream { render :new, status: :bad_request }
        format.html { render :new, status: :unprocessable_entity, notice: 'Team cannot be created.' }
      end
    end
  end

  # For development
  def destroy_all
    authorize Team
    Team.all.destroy_all
    redirect_to root_path
  end

  private

  def build_current_user_team
    @team = current_user.dup.teams.build
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
