class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :documentable, polymorphic: true, index: true, null: false
      t.text :attachment_data

      t.timestamps
    end
  end
end
