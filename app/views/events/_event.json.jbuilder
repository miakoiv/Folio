json.extract! event, :id, :title
json.user event.user.to_s
json.person event.customer.person.to_s if event.customer.present?
json.edit_url edit_event_path(event, format: :js)
json.update_url event_path(event, format: :js)
json.start event.starts_at
json.end event.ends_at
json.className event.rendering(current_user, @customer)
json.editable event.updatable_by?(current_user)
json.popover ApplicationController.render(partial: 'events/popover', object: event, as: :event)
