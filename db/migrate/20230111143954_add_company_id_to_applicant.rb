class AddCompanyIdToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants, :company_id, :uuid
  end
end
