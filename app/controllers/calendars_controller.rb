class CalendarsController < ApplicationController
  def index
    @events = Event.all.includes(:user)
  end
end
