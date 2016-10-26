class CreateLiaisons < ActiveRecord::Migration[5.0]
  def change
    create_table :liaisons do |t|
      t.belongs_to :unit, foreign_key: true
      t.belongs_to :person, foreign_key: true
      t.integer :status
      t.belongs_to :referrer, foreign_key: true
      t.string :referrer_info
      t.text :notes

      t.timestamps
    end
  end
end
