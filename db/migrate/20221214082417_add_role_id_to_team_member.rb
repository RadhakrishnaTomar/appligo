class AddRoleIdToTeamMember < ActiveRecord::Migration[7.0]
  def change
    add_column :team_members, :role_id, :integer
  end
end
