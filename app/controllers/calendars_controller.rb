class CalendarsController < ApplicationController
  before_action :set_teams, only: %i[ :index ]
  before_action :set_calendars, only: %i[ :index ]

  def index
    @calendar      = Calendar.new
    @events        = Event.all.includes(:calendar)
    @event         = Event.new
    @organizations = Organization.select(:id, :fullname)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('calendar', partial: 'calendars/calendar') }
      format.html
    end
  end

  def create
    @calendar = Calendar.new(
      name: params.dig(:calendar, :name),
      background_color: params.dig(:calendar, :background_color)
    )

    respond_to do |format|
      if @calendar.save
        @calendars     = Calendar.all.includes(:events)
        @event         = Event.new
        @organizations = Organization.select(:id, :fullname)

        format.turbo_stream
        format.html { redirect_to root_path, notice: "calendar was successfully created." }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('calendar-form', partial: 'form', locals:  { calendar: @calendar })
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_teams
    @teams = Team.of_user(current_user) if current_user
  end

  def set_calendars
    @calendars = @teams&.map(&:calendars)
  end
end
