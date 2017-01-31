class CreateMilestones < ActiveRecord::Migration[5.0]
  def change
    create_table :milestones do |t|
      t.belongs_to :milestone_type, null: false
      t.string :name_fi

      t.timestamps
    end
  end
end
