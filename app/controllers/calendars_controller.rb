class CalendarsController < ApplicationController
  def index
    @events = Event.all
  end
end
