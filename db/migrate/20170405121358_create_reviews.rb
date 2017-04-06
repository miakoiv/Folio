class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false
      t.belongs_to :customer, null: false
      t.string :title
      t.text :content
      t.date :published_at

      t.timestamps
    end
  end
end
