class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all.includes(:events)
    @events    = Event.all
    @event     = Event.new
    @users     = User.select(:id, :fullname)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(
      name: params.dig(:calendar, :name),
      background_color: params.dig(:calendar, :background_color)
    )

    respond_to do |format|
      if @calendar.save
        format.html { redirect_to root_path, notice: "calendar was successfully created." }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end
end
