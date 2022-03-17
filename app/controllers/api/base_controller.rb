# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    skip_before_action :authenticate_user!
    before_action :set_default_format
    before_action :authenticate!

    private

    def set_default_format
      request.format = :json
    end

    def authenticate!
      session? ? authenticate_user! : authenticate_token!
    end

    def authenticate_token!
      payload       = JsonWebToken.decode auth_token
      @current_user = User.find payload['sub']
    rescue JWT::VerificationError
      render json: { errors: ['Invalid authentication: verification error'] }, status: :unauthorized
    rescue JWT::ExpiredSignature
      render json: { errors: ['Invalid authentication: signature expired'] }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: ['Invalid authentication'] }, status: :unauthorized
    end

    def auth_token
      @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
    end

    def session?
      !!session[:session_id]
    end
  end
end
