# frozen_string_literal: true

class SecretLinksController < ApplicationController
  def create
    @secret_link = SecretLink.new(secret_link_params)

    respond_to do |format|
      format.turbo_stream {} if @secret_link.save
    end
  end

  private

  def secret_link_params
    attributes = %i[slug validity_period visit_count calendar_id user_id]
    params.require(:secret_link).permit(attributes)
  end
end
