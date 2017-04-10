class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.integer :purpose, null: false, default: 0
      t.belongs_to :unit, null: false, index: true
      t.text :content

      t.timestamps
    end
  end
end
