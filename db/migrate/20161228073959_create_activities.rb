class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.belongs_to :unit, null: false, index: true
      t.belongs_to :whodunnit, null: false, index: true
      t.string :action
      t.references :resource, polymorphic: true, null: false, index: true
      t.text :differences

      t.timestamps
    end
  end
end
