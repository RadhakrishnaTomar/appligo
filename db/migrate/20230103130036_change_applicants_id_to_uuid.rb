class ChangeApplicantsIdToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    change_table :applicants do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE applicants ADD PRIMARY KEY (id);"
  end
end
