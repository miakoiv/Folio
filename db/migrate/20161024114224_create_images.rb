class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.belongs_to :imageable, polymorphic: true, index: true, null: false
      t.text :attachment_data

      t.timestamps
    end
  end
end
