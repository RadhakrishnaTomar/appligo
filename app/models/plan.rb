class Plan < ApplicationRecord
	has_many :subscriptions
	validates :name, presence: true, uniqueness: { scope: :name, case_sensitive: false, message: "Plan has already been taken!" }
end
