require 'roo'

class BulkUpload < ApplicationRecord
  belongs_to :team_member
  has_one_attached :excel_doc
  validate :correct_document_mime_type

  private

  def correct_document_mime_type
    if excel_doc.attached? && excel_doc.content_type != 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      excel_doc.purge
      errors.add(:excel_doc, 'Must be a xlsx')
    end
  end
end
