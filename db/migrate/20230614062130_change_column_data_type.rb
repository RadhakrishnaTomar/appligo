class ChangeColumnDataType < ActiveRecord::Migration[7.0]
  def change
    change_column :applicants, :last_salary, :string
    change_column :applicants, :expected_ctc, :string
  end
end
