class CreatePolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :policies do |t|
      t.string :title
      t.text :content
      t.boolean :mandatory, null: false, default: true
      t.datetime :accepted_at
      t.belongs_to :accepted_by

      t.timestamps
    end
  end
end
