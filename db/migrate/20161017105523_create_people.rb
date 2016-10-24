class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :identification, null: false, index: true
      t.date :date_of_birth
      t.string :last_name, index: true
      t.string :first_names
      t.string :gender, limit: 1
      t.string :email
      t.string :phone
      t.string :address
      t.belongs_to :postcode, type: :string, limit: 5, index: true
      t.belongs_to :municipality
      t.string :language, limit: 2
      t.string :nationality, limit: 2
      t.string :accommodation
      t.text :restrictions
      t.text :referrals
      t.text :information

      t.timestamps
    end
  end
end
