class Profile < ApplicationRecord
  validates :name, :create_by , :description, :company_id, presence: true
  belongs_to :company
  has_many :applicants
end