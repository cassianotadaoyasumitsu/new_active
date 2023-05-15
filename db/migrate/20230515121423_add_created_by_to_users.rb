class AddCreatedByToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :created_by, foreign_key: { to_table: :users }

    User.reset_column_information
    first_user = User.first
    User.find_each do |user|
      user.update_column(:created_by_id, first_user.id) if first_user
    end
  end
end
