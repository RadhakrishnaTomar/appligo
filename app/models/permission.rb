class Permission < ApplicationRecord
  belongs_to :company
  belongs_to :role
  validates :model_title, uniqueness: { scope: [:role_id, :company_id], message: 'Permission Already exist' }
  validates :company_id, :role_id, :model_title,  presence: true

  def self.all_tables
    (ActiveRecord::Base.connection.tables - ["schema_migrations","ar_internal_metadata","active_storage_blobs","active_storage_attachments","active_storage_variant_records"]).map{|m| m.singularize}
  end

  def self.all_models
    all_tables.map{|m| m.gsub("_", " ").titlecase.gsub(" ", "")}
  end
end
