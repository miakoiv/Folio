class CreateMemos < ActiveRecord::Migration[5.0]
  def change
    create_table :memos do |t|
      t.belongs_to :unit, null: false
      t.string :title
      t.text :content

      t.belongs_to :creator, null: false
      t.timestamps
    end
  end
end
