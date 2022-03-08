class Api::V1::EventsController < Api::BaseController
  def index
    @events = Event.of_team(event_params[:team_name])
                   .between_dates(event_params[:start_date], event_params[:end_date])
  rescue ActionController::ParameterMissing
      render json: { errors: ['Invalid request: missing parameters'] }, status: :bad_request
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :end_date, :team_name)
  end
end
