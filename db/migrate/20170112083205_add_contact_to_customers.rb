class AddContactToCustomers < ActiveRecord::Migration[5.0]
  def up
    add_reference :customers, :contact, null: false, index: true, after: :person_id

    Customer.all.each do |customer|
      creation = customer.activities.find_by(action: 'create')
      customer.update_columns(contact_id: creation.whodunnit_id) if creation
    end
  end

  def down
    remove_reference :customers, :contact, index: true
  end
end
