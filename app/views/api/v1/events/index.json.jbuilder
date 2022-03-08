json.array! @events do |event|
  json.start         event.start_date.iso8601
  json.end           event.end_date&.iso8601
  json.title         event.title
  json.calendar_name event.calendar.name
  json.color         event.calendar.background_color
  json.textColor     event.calendar.text_color
  json.display       'block'
end
