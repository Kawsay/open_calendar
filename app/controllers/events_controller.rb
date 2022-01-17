class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy _show_modal ]
  before_action :set_users, only: %i[ new create edit update _add_modal ]
  before_action :check_for_range_date!, only: %i[ create update ]

  # GET /events or /events.json
  def index
    @events = Event.includes(:user)
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
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_path, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
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

  # GET /add_event_modal
  def _add_modal
    @event = Event.new(event_params)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.includes(:documents).find(params[:id])
    end

    def set_users
      @users = User.select(:id, :fullname)
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
            .permit(:title, :start_date, :end_date, :location, :description, :user_id, :file, :is_related_to_a_user,
                    documents_attributes: [:id, :title, :description, :file, :documentable_type, :documentable_id],
                    user_attributes: [:id])
    end
end
