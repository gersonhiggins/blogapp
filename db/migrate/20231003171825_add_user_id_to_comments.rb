class AddUserIdToComments < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:comments, :user_id)
      add_column :comments, :user_id, :integer
      add_index :comments, :user_id
    end
  end
end
