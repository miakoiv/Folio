class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.belongs_to :post, null: false
      t.belongs_to :author, null: false
      t.text :content

      t.timestamps
    end
  end
end
