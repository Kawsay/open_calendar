class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy _show_modal ]
  before_action :set_organizations, only: %i[ new create edit update ]
  before_action :check_for_range_date!, only: %i[ create update ]

  # GET /events or /events.json
  def index
    @events = Event.includes(:organization)
  end

  # GET /events/1 or /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.documents.build
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event         = Event.new(event_params)
    @organizations = Organization.select(:id, :name)

    respond_to do |format|
      if @event.save
        team       = Calendar.find_by(id: event_params[:calendar_id]).team
        @calendars = Calendar.where(team: team).includes(:events)
        @events    = Event.where(calendar: @calendars)
        @new_event = Event.new

        format.turbo_stream { render :create, status: :see_other }
        format.html { redirect_to root_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.turbo_stream { render :create, status: :bad_request }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /events_modal/1
  def _show_modal
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.includes(:documents).find(params[:id])
    end

    def set_organizations
      @organizations = Organization.select(:id, :name)
    end

    # In case user selects a range date, Flatpickr will send a String like
    # "07/01/2022 00:00 to 11/01/2022 00:00".
    # This method split both date on "to", parses each date, and assigns both
    # date to the corresponding parameter.
    # In case a single date is picked, `:end_date` will stay equals to `nil`
    def check_for_range_date!
      params[:event][:start_date], params[:event][:end_date] =
        event_params[:start_date].split(/\s\w+\s/).map do |date|
          DateTime.parse(date)
        end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event)
            .permit(:title, :start_date, :end_date, :location, :description, :organization_id, :file, :is_related_to_a_user, :calendar_id,
                    organizations_attributes: [:id])
    end
end
