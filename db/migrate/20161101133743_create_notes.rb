class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :customer
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
