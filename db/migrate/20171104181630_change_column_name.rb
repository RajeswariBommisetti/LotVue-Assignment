class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
  	rename_column :user_roles, :role, :role_id
  end
end
