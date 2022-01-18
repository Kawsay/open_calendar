class EventTypesController < ApplicationController
  before_action :set_event_type, only: %i[ show edit update destroy _show_modal ]
  before_action :convert_text_color_param_to_int, only: %i[ create update ]

  # GET /event_types/new
  def new
    @event_type = EventType.new
  end

  # GET /event_types/1/edit
  def edit
  end

  # POST /event_types or /event_types.json
  def create
    @event_type = EventType.new(event_type_params)

    respond_to do |format|
      if @event_type.save
        format.html { redirect_to root_path, notice: "Event type was successfully created." }
        format.json { render :show, status: :created, location: @event_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_types/1 or /event_types/1.json
  def update
    respond_to do |format|
      if @event_type.update(event_params)
        format.html { redirect_to @event_type, notice: "Event type was successfully updated." }
        format.json { render :show, status: :ok, location: @event_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_types/1 or /event_types/1.json
  def destroy
    @event_type.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_type
      @event_type = EventType.find(params[:id])
    end

    # `text_color` parameter is passed as a String, but must be an Int as
    # it is related to an Enum.
    def convert_text_color_param_to_int
      params[:event_type][:text_color] = params[:event_type][:text_color].to_i
    end

    # Only allow a list of trusted parameters through.
    def event_type_params
      params.require(:event_type).permit(:name, :background_color, :text_color)
    end
end
