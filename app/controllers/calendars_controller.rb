class CalendarsController < ApplicationController
  def index
    @events = Event.all.includes(:user)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
