class Changecolunmapplicant < ActiveRecord::Migration[7.0]
  def change
    remove_column :applicants, :open_for, :boolean
    add_column :applicants, :open_for, :string
  end
end
