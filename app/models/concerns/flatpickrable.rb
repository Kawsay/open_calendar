# frozen_string_literal: true

module Flatpickrable
  # TODO: I18n
  def flatpickr_dates_format
    return nil if self.start_date.nil? && self.end_date.nil?

    [
      flatpickr_date_format(self.start_date),
      flatpickr_date_format(self.end_date)
    ].compact.join(' au ')
  end

  private

  def flatpickr_date_format(date)
    date&.strftime '%d/%m/%Y %H:%M'
  end
end
