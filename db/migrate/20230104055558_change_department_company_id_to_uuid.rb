class ChangeDepartmentCompanyIdToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :departments, :uuid, :uuid, default: "uuid_generate_v4()", null: false

    change_table :departments do |t|
      t.remove :company_id
      t.rename :uuid, :company_id
    end
  end
end
