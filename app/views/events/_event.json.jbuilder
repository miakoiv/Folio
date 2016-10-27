json.url event_url(event, format: :json)
json.title event.title
json.start event.starts_at
json.end event.ends_at
json.allDay event.all_day
