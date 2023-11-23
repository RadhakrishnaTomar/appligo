class AddColumnIntoApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :company_name, :string
  end
end
