class CreateUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :units do |t|
      t.string :name_fi, null: false

      t.timestamps
    end
  end
end
