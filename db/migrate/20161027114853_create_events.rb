class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :liaison, null: false
      t.belongs_to :event_type, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.boolean :all_day, null: false, default: false
      t.string :title, null: false
      t.text :description

      t.belongs_to :creator, null: false
      t.timestamps
    end
  end
end
