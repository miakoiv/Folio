class CreateMunicipalities < ActiveRecord::Migration[5.0]
  def change
    create_table :municipalities do |t|
      t.string :name_fi, null: false
      t.string :name_sv, null: false
    end
  end
end
