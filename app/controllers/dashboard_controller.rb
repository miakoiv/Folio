class DashboardController < ApplicationController

  def index
    @user_customers = current_user.customers.at(current_unit)
      .includes(:person).reorder(updated_at: :desc)
    @unit_customers = current_unit.customers.without_contact
    @top_notes = current_unit.notes.includes(customer: :person).limit(10)
  end
end
