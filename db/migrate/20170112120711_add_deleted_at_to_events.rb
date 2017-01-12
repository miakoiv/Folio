class AddDeletedAtToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :deleted_at, :timestamp
  end
end
