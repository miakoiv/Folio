class AddLegalGuardianToRelationships < ActiveRecord::Migration[5.0]
  def change
    add_column :relationships, :legal_guardian, :boolean, null: false, default: false, after: :relation_id
  end
end
