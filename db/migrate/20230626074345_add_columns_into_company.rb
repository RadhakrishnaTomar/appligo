class AddColumnsIntoCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :website_url, :string
    add_column :companies, :linkedin_url, :string
    add_column :companies, :facebook_url, :string
    add_column :companies, :registration_status, :integer, default: 0
    add_column :companies, :number_of_employees, :integer, default: 0
    add_column :companies, :industry_type, :string

  end
end
