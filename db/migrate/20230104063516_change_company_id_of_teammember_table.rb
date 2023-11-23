class ChangeCompanyIdOfTeammemberTable < ActiveRecord::Migration[7.0]
  def change
    add_column :team_members, :uuid, :uuid, default: "uuid_generate_v4()", null: false
   
    change_table :team_members do |t|
      t.remove :company_id
      t.rename :uuid, :company_id
    end
  end
end
