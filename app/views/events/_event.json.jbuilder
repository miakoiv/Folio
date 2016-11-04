json.extract! event, :id, :title, :description
json.person event.liaison.person.to_s
json.edit_url edit_event_path(event, format: :js)
json.update_url event_path(event, format: :js)
json.start event.starts_at
json.end event.ends_at
json.className [event.appearance, event.topical?(@liaison) ? 'topical' : nil]
