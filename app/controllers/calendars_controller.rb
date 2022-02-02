class CalendarsController < ApplicationController
  def index
    @events = Event.all.includes(:user, :event_type)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
