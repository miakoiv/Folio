class CreateMemos < ActiveRecord::Migration[5.0]
  def change
    create_table :memos do |t|
      t.belongs_to :sender, null: false
      t.string :icon
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
