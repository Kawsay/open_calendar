class CalendarsController < ApplicationController
  before_action :set_teams, only: %i[ index create ]
  before_action :set_current_or_favorite_team, only: %i[ index new create ]
  before_action :build_new_calendar, only: %i[ index new ]

  def index
    @calendars     = Calendar.where(team: @current_team)
    @events        = Event.of_calendars(@calendars)
    @organizations = Organization.select(:id, :name)
    @new_event     = Event.new
  end

  def new
    respond_to do |format|
      format.html {}
    end
  end

  def create
    @new_calendar = Calendar.new(calendar_params)

    respond_to do |format|
      if @new_calendar.save
        format.html { redirect_to team_calendars_path, notice: "calendar was successfully created." }
        format.json { render :show, status: :created, location: @new_calendar }
      else
        if @current_team.calendars.blank?
          format.turbo_stream { render :new, status: :bad_request}
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @new_calendar.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  def set_teams
    @teams = Team.of_user(current_user).by_favorite if user_signed_in?
  end

  def set_current_or_favorite_team
    @current_team = params.has_key?(:team_id) ? Team.find(params[:team_id]) : Team.user_favorite(current_user)
  end

  def build_new_calendar
    @new_calendar = @current_team.dup.calendars.build
  end

  def calendar_params
    params.require(:calendar).permit(:name, :background_color, :team_id)
  end
end
