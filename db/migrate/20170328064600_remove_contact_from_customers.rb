class RemoveContactFromCustomers < ActiveRecord::Migration[5.0]
  def change
    remove_reference :customers, :contact, null: false, after: :person_id
  end
end
