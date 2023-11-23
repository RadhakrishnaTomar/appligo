class Applicant < ApplicationRecord
	belongs_to :company
	belongs_to :profile
	has_many :interviews, dependent: :destroy

	validates  :name , :contact_number, :email , :location, :current_ctc, :expected_ctc, :notice_period, :source, presence: true

	validates :email, :contact_number, uniqueness: { case_sensitive: true }
	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates_uniqueness_of :name, :case_sensitive => true

	has_one_attached :excel_doc

	enum :open_for, { home: 'home', office: 'office' , anywhere: 'anywhere'}

	def self.search(search, email, location, contact_number, open_for)
		if search.present?
			results = Applicant.all.where("name ILIKE ? or location ILIKE ? or contact_number ILIKE ? or email ILIKE ? or contact_number ILIKE ? or open_for ILIKE ? or source ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%")

			if search.present?
				results.where("email ILIKE ? and location ILIKE ? and contact_number ILIKE ? and open_for ILIKE ? ", "%#{email}%", "%#{location}%", "%#{contact_number}%", "%#{open_for}%")
			end
		
		elsif email.present? or location.present? or contact_number.present? or open_for.present?
			where("email ILIKE ? and location ILIKE ? and contact_number ILIKE ? and open_for ILIKE ? ", "%#{email}%", "%#{location}%", "%#{contact_number}%", "%#{open_for}%")

		else search.blank?
			all
		end
	end
end
