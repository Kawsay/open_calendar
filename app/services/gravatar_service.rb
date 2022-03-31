# frozen_string_literal: true

require 'digest'

class GravatarService
  attr_reader :url

  BASE_URL = 'https://gravatar.com/avatar'

  def initialize(email)
    @email = email
    @hash  = compute_md5_hash(email)
    @url   = gravatar_url(self.hash)
  end

  private

  def compute_md5_hash(email)
    Digest::MD5.hexdigest email
  end

  def gravatar_url(hash)
    [BASE_URL, hash].join('/')
  end
end
