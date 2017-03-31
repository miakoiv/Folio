class AddUnitToEvents < ActiveRecord::Migration[5.0]
  def up
    add_reference :events, :unit, index: true, null: false, after: :id

    Event.find_each(batch_size: 50) do |event|
      event.update unit_id: event.user.unit_id
    end
  end

  def down
    remove_reference :events, :unit, index: true, null: false, after: :id
  end
end
