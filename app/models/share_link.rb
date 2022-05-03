# frozen_string_literal: true

class ShareLink
  IDENTIFIABLE_OBJECTS = %w[Calendar]

  def self.identify_requested_object(token)
    IDENTIFIABLE_OBJECTS.inject(nil) do |memo, obj|
      obj.constantize.find_by(id: token[:sub])
    end
  end
end
