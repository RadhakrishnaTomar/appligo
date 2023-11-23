class AddColumnToRole < ActiveRecord::Migration[7.0]
  def change
    add_column :roles, :company_id, :uuid
    add_column :roles, :create_by, :string
    add_column :permissions, :update_p, :boolean, default: false, null: false
    rename_column :permissions, :write_p, :create_p
  end
end
