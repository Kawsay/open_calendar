# frozen_string_literal: true

class CalendarsController < ApplicationController
  before_action :build_new_calendar, only: %i[index new]
  skip_before_action :authenticate_user!, only: :show

  def index
    @calendars     = Calendar.where(team: @current_team)
    @events        = Event.where(calendar: @calendars)
    @organizations = Organization.select(:id, :name)
    @attendees     = @current_team.users.select(:id, :pseudonym)
    @new_event     = Event.new

    authorize Calendar.find_by(team: @current_team)
  end

  def show
    @calendar = authorize(Calendar.find(params[:id]))
  end

  def new
    authorize @new_calendar
    respond_to do |format|
      format.html {}
    end
  end

  def create
    @new_calendar = Calendar.new(calendar_params)
    authorize @new_calendar

    respond_to do |format|
      if @new_calendar.save
        format.html { redirect_to team_calendars_path, notice: 'calendar was successfully created.' }
        format.json { render :show, status: :created, location: @new_calendar }
      elsif @current_team.calendars.blank?
        format.turbo_stream { render :new, status: :bad_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @new_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def build_new_calendar
    @new_calendar = @current_team.dup.calendars.build
  end

  def calendar_params
    params.require(:calendar).permit(:name, :background_color, :team_id)
  end
end
