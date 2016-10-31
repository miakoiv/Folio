class CreateLiaisons < ActiveRecord::Migration[5.0]
  def change
    create_table :liaisons do |t|
      t.belongs_to :user, null: false
      t.belongs_to :person, null: false
      t.belongs_to :status, null: false, default: 0
      t.belongs_to :referrer
      t.string :referrer_info
      t.text :notes

      t.belongs_to :creator, null: false
      t.timestamps
    end
  end
end
