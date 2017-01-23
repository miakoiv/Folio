class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.belongs_to :unit, null: false
      t.belongs_to :author, null: false
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
