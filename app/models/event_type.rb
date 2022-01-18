class EventType < ApplicationRecord
  enum text_color: {
    dark: 0,
    white: 1
  }
end
