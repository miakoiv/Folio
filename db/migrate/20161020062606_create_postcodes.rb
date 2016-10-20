class CreatePostcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :postcodes, id: false do |t|
      t.string :code, limit: 5, null: false, index: true
      t.string :town, null: false
    end
  end
end
