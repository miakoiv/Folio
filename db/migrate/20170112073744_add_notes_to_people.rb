class AddNotesToPeople < ActiveRecord::Migration[5.0]
  def change
    add_column :people, :notes, :text, after: :disabilities
  end
end
