class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.belongs_to :customer, null: false
      t.belongs_to :milestone, null: false
      t.date :reached_at, null: false
      t.text :notes

      t.timestamps
    end
  end
end
