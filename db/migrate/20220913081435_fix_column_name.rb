class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :password_reset_token, :reset_password_token
    rename_column :users, :password_reset_sent_at, :reset_password_token_sent_at
    remove_column :users, :email
    add_column :users, :email, :string, null: false, default: ""
  end
end
