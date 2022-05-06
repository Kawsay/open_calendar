# frozen_string_literal: true

class ShareLinksController < ApplicationController
  before_action :skip_authorization
  skip_before_action :authenticate_user!, only: :authorize_request

  def create
    payload = {
      iss: current_user.id,
      sub: share_link_params[:calendar_id]
    }

    slug = JsonWebToken.encode(payload)
    @calendar_id = share_link_params[:calendar_id]
    @share_link  = root_url + 'calendars/shared/' + slug

    respond_to do |format|
      format.turbo_stream {}
    end
  end

  def authorize_request
    token = JsonWebToken.decode(params[:token])

    if JsonWebToken.valid?(token)
      session[:jwt] = params[:token]

      object     = ShareLink.identify_requested_object(token)
      controller = object.class.to_s.underscore.pluralize

      redirect_to controller: 'calendars', action: 'show', id: object.id
    end
  end

  private

    def share_link_params
      params.require(:share_link).permit(:calendar_id)
    end
end
