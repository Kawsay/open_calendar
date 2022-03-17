# frozen_string_literal: true

module Api
  module V1
    class EventsController < Api::BaseController
      def index
        @events = Event.includes(calendar: :team)
                       .where(team: { name: event_params[:team_name] })
                       .between_dates(event_params[:start_date], event_params[:end_date])

        authorize Team.find_by(name: event_params[:team_name]), :show?
      rescue ActionController::ParameterMissing
        render json: { errors: ['Invalid request: missing parameters'] }, status: :bad_request
      end

      private

      def event_params
        params.require(:event).permit(:start_date, :end_date, :team_name)
      end
    end
  end
end
