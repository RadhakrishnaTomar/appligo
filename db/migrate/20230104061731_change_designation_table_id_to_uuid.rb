class ChangeDesignationTableIdToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :team_members, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    add_column :designations, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    remove_column :designations, :integer
   
    change_table :team_members do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    change_table :designations do |t|
      t.remove :id
      t.rename :uuid, :id
    end
  end
end
