class CreateOrganisationSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :organisation_settings, id: :uuid do |t|
      t.boolean :applicantseditableview
      t.timestamps
    end
  end
end
