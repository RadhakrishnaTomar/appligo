class AddNewAndRenameAttributeToApplicant < ActiveRecord::Migration[7.0]
  def change
    add_column :applicants,:remark, :text
    add_column :applicants,:hometown, :string
    add_column :applicants,:last_company, :string
    add_column :applicants, :experience, :float
    add_column :applicants, :relevant_expereince,:text
    add_column :applicants, :reason, :text
    rename_column :applicants,:last_salary,:current_ctc
  end
end
