class AddStartedAtToCustomers < ActiveRecord::Migration[5.0]
  def up
    add_column :customers, :started_at, :date, after: :referrer_info

    # Update existing customers with starting dates from creation timestamp.
    Customer.unscoped.find_each(batch_size: 50) do |c|
      c.update_columns started_at: c.created_at
    end

    change_column_null :customers, :started_at, false
  end

  def down
    remove_column :customers, :started_at
  end
end
