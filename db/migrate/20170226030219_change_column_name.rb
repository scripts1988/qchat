class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :password_digit, :password_digest
  end
end
