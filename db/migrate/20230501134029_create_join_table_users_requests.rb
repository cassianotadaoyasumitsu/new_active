class CreateJoinTableUsersRequests < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :requests do |t|
      t.index [:user_id, :request_id]
      t.index [:request_id, :user_id]
    end
  end
end
