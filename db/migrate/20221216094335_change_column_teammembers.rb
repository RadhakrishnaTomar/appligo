class ChangeColumnTeammembers < ActiveRecord::Migration[7.0]
  def change
    rename_column :team_members, :company_id, :employee_id
    add_column :team_members, :contact_number, :string
    remove_column :team_members, :designation
    rename_column :team_members, :role_id, :designation_id
  end
end
