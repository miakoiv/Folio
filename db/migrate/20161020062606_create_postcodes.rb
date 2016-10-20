class CreatePostcodes < ActiveRecord::Migration[5.0]
  def change
    create_table :postcodes, id: false do |t|
      t.string :code, limit: 5, null: false, index: true
      t.string :name_fi, null: false
      t.string :name_sv, null: false
      t.belongs_to :municipality, null: false
    end
  end
end
