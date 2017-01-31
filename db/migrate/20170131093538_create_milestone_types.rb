class CreateMilestoneTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :milestone_types do |t|
      t.string :name_fi

      t.timestamps
    end
  end
end
