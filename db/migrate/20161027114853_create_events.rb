class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :user, null: false
      t.belongs_to :event_type, null: false
      t.belongs_to :customer
      t.datetime :starts_at, null: false
      t.integer :duration, null: false
      t.datetime :ends_at
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
