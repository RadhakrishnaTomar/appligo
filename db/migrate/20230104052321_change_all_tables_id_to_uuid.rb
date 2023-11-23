class ChangeAllTablesIdToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    add_column :roles, :uuid, :uuid, default: "uuid_generate_v4()", null: false
    add_column :departments, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    change_table :companies do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    change_table :roles do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    change_table :departments do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE companies ADD PRIMARY KEY (id);"
    execute "ALTER TABLE roles ADD PRIMARY KEY (id);"
    execute "ALTER TABLE departments ADD PRIMARY KEY (id);"
  end
end
