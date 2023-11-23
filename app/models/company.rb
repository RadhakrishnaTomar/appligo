class Company < ApplicationRecord
	has_many :team_members, inverse_of: :company, dependent: :destroy
	has_many :departments, dependent: :destroy
	has_many :applicants, dependent: :destroy
	has_many :permissions, dependent: :destroy
	has_many :subscriptions
	has_many :plans, through: :subscriptions
	has_one_attached :logo
  has_one :organisation_setting
	after_create :basic_plan_addon
  has_one :saml_setting
  has_many :profiles

	accepts_nested_attributes_for :team_members
	accepts_nested_attributes_for :permissions
	after_update :update_registration_status
	
	#validates :name, presence: true, :uniqueness => { :case_sensitive => false }, on: :update
	#validates :location, :number_of_employees, :industry_type, presence: true, on: :update
	enum registration_status: { on_board: 0, completed: 1 }

  protected

  def basic_plan_addon
    self.subscriptions.create(
      subscribed_app: "Appligo",
      start_date: DateTime.now, 
      end_date: DateTime.now + 1.year, 
      plan: Plan.find_by(name: "Basic")
    )
  end
  
  def update_registration_status
    return if completed? # Exit if already set to success

    if attribute_present?(:name) && attribute_present?(:location) && attribute_present?(:number_of_employees) && attribute_present?(:industry_type)
      self.completed!
    end
  end
end
