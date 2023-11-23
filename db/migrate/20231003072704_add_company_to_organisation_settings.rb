class AddCompanyToOrganisationSettings < ActiveRecord::Migration[7.0]
  def change
     add_reference :organisation_settings, :company,type: :uuid, foreign_key: true
  end
end
