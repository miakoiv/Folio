class CreateReferrers < ActiveRecord::Migration[5.0]
  def change
    create_table :referrers do |t|
      t.string :name_fi, null: false
      t.boolean :needs_info, null: false, default: false
    end
  end
end
