class Api::V1::EventsController < Api::BaseController
  def index
    @events = Event.joins(calendar: :team)
                   .where('start_date >= ? AND start_date < ?',
                          event_params[:start_date], event_params[:end_date])
                   .where('"teams"."name" = ?',
                          event_params[:team_name])

    respond_to do |format|
      format.json
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :end_date, :team_name)
  end
end
