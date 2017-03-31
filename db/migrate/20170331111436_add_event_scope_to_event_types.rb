class AddEventScopeToEventTypes < ActiveRecord::Migration[5.0]
  def up
    add_column :event_types, :event_scope, :integer, null: false, default: 0, after: :id

    personal = EventType.create name_fi: 'Oma toiminta', appearance: 'personal', event_scope: 1
    shared   = EventType.create name_fi: 'Yhteinen tapahtuma', appearance: 'shared', event_scope: 2

    Event.where(event_type_id: 0).update_all(event_type_id: personal.id)
  end

  def down
    EventType.where(event_scope: [1,2]).destroy_all

    remove_column :event_types, :event_scope
  end
end
