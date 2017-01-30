class AllowNullContactIdOnCustomers < ActiveRecord::Migration[5.0]
  def up
    change_column_null :customers, :contact_id, true
  end

  def down
    change_column_null :customers, :contact_id, false, 0
  end
end
