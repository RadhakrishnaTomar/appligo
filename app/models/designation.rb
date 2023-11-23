class Designation < ApplicationRecord
	belongs_to :department
	validates :name, presence: true, uniqueness: {scope: :department, case_sensitive: false, message: "of designation is already created	"}
	validates :department_id, presence: true
end
