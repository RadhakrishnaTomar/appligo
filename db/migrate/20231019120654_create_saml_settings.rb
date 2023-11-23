class CreateSamlSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :saml_settings, id: :uuid do |t|
      t.string :sso_url
      t.string :slo_url
      t.string :password_url
      t.text :certificate
      t.string :app_uuid
      t.string :org_uuid
      t.references :company, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
