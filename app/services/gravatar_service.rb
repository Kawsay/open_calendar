# frozen_string_literal: true

require 'digest'

class GravatarService
  attr_reader :url

  BASE_URL       = 'https://gravatar.com/avatar'
  DEFAULT_SIZE   = '40'
  DEFAULT_AVATAR = 'retro'

  def initialize(email)
    @email = email
    @hash  = compute_md5_hash
    @url   = gravatar_url
  end

  private

  def compute_md5_hash
    Digest::MD5.hexdigest formatted_email
  end

  def formatted_email
    @email.strip.downcase
  end

  def gravatar_url
    "#{BASE_URL}/#{@hash}?s=#{DEFAULT_SIZE}&d=#{DEFAULT_AVATAR}"
  end
end
