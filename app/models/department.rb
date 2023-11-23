class Department < ApplicationRecord
	has_many :designations, dependent: :destroy
	belongs_to :company
	validates :name, presence: true, uniqueness: { scope: :company, case_sensitive: false, message: "of department is already created	" }
	validates :company_id, presence: true
end
