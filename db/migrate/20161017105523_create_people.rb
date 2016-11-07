class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :identification
      t.date :date_of_birth
      t.string :last_name, index: true
      t.string :first_names
      t.string :gender, limit: 1
      t.string :email
      t.string :phone
      t.string :address
      t.belongs_to :postcode, type: :string, limit: 5
      t.belongs_to :municipality
      t.string :language, limit: 2
      t.string :nationality, limit: 2
      t.belongs_to :education_level
      t.string :education_info
      t.string :accommodation
      t.string :disabilities

      t.belongs_to :creator, null: false
      t.timestamps
    end
  end
end
