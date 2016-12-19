class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :customer, null: false
      t.string :title
      t.text :content

      t.belongs_to :creator, null: false
      t.timestamps
    end
  end
end
