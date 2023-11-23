class AddCompanyIdToTeamMember < ActiveRecord::Migration[7.0]
  def change
    add_column :team_members, :company_id, :integer
    rename_column :team_members, :designation_id, :role_id 
  end
end
