class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :last_name
      t.string :first_names
      t.date :activates_at
      t.date :expires_at

      t.timestamps
    end
  end
end
