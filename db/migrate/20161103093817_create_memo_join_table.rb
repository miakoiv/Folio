class CreateMemoJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :memos, :users do |t|
      # t.index [:memo_id, :user_id]
      t.index [:user_id, :memo_id], unique: true
    end
  end
end
