class Role < ApplicationRecord
	has_many :team_members, dependent: :destroy
	has_many :permissions, dependent: :destroy

  scope :admin, -> { where(name: "Admin") }
end
