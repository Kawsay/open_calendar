# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, expiration: 1.week.from_now)
    payload[:iat] = Time.now.to_i
    payload[:exp] = expiration.to_i
    JWT.encode payload, SECRET_KEY
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(
      JWT.decode(token, SECRET_KEY).first
    )
  end

  def self.valid?(token)
    user_exists?(token[:iss]) && isnt_expired?(token[:exp], token[:iat])
  end

  private

    def self.user_exists?(user_id)
      User.exists?(user_id)
    end

    def self.isnt_expired?(expiration_time, issued_at)
      (expiration_time - issued_at) >= (expiration_time - Time.now.to_i)
    end
end
