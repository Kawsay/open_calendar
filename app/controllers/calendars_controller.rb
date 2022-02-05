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
end
