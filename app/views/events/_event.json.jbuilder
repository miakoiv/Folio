json.extract! event, :id, :title, :description
json.edit_url edit_event_path(event, format: :js)
json.start event.starts_at
json.end event.ends_at
json.allDay event.all_day
