class Renamecol < ActiveRecord::Migration[7.0]
  def change
    rename_column :companies, :company_name, :name
    rename_column :companies, :company_location, :location
  end
end
