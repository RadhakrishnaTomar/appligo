class ChangeDesignationTableDepartmentIdAndRoleIdOfTeammember < ActiveRecord::Migration[7.0]
  def change
    add_column :team_members, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    add_column :designations, :uuid, :uuid, default: "uuid_generate_v4()", null: false
   
    change_table :team_members do |t|
      t.remove :role_id
      t.rename :uuid, :role_id
    end
    change_table :designations do |t|
      t.remove :department_id
      t.rename :uuid, :department_id
    end
  end
end
