class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.belongs_to :person, null: false
      t.belongs_to :parent, null: false
      t.belongs_to :relation, null: false

      t.timestamps
    end
  end
end
