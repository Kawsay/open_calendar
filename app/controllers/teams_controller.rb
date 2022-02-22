class TeamsController < ApplicationController
  before_action :set_user_teams, only: %i[show]
  before_action :set_user_team, only: %i[show]
  before_action :set_calendars, only: %i[show]

  def show
    respond_to do |format|
      format.html { }
    end
  end

  def create
    @team = current_user.teams.build(team_params)
    @team.memberships.new(user_id: current_user.id)

    puts @team.inspect
    puts @team.memberships.inspect
    
    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: 'Team was successfully created.' }
      else
        format.html { redirect_to root_path, notice: 'Team was successfully created.' }
      end
    end
  end

  private

  def set_user_teams
    @teams = Team.of_user(current_user) if current_user
  end

  def set_user_team
    @team = current_user.teams.build
  end

  def set_calendars
    @calendars = @teams.includes(:calendars).map(&:calendars) rescue nil
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
