class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.belongs_to :memo, index: true, null: false
      t.belongs_to :recipient, polymorphic: true, index: true, null: false
      t.datetime :accessed_at

      t.timestamps
    end
  end
end
