class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.belongs_to :memo, null: false
      t.belongs_to :user, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
