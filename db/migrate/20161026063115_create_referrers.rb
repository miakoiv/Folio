class CreateReferrers < ActiveRecord::Migration[5.0]
  def change
    create_table :referrers do |t|
      t.string :name_fi
      t.boolean :needs_info
    end
  end
end
