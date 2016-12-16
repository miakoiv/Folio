class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
      t.belongs_to :memo, null: false
      t.belongs_to :user, null: false

      t.timestamps
    end
    add_index :collections, [:memo_id, :user_id], unique: true
  end
end
