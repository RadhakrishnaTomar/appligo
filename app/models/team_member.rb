class TeamMember < ApplicationRecord
  has_many :interviews, dependent: :destroy
  devise  :database_authenticatable,:registerable,
  :recoverable, :rememberable
  #validates :password ,presence:false
  belongs_to :company, inverse_of: :team_members
  belongs_to :role
  has_many :bulk_uploads 
  accepts_nested_attributes_for :company
  has_many :comments, dependent: :destroy
  has_many :permissions, ->(team_member) { where("permissions.role_id = ?", team_member.role_id) }, through: :company
  after_create :admin_all_permission

  # validates :name, :employee_id , :role_id , :contact_number, presence: true
  # validates_uniqueness_of :employee_id, :contact_number, :case_sensitive => true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def admin?
    self.role.name == "Admin"
  end

  def hr?
    self.role.name == "HR"
  end

  def moderator?
    self.role.name == "Moderator"
  end

  def admin_all_permission
    if !self.role.company_id? && !self.role.create_by?
      role_up = self.role
      role_up.update(company_id: self.company.id, create_by: self.name)
    end
    models_name = Permission.all_models
    if self.role.name == "Admin"
      models_name.each do |model|
        permission = Permission.create(company_id: self.company_id, role_id: self.role_id, model_title: model, read_p: true, create_p: true, delete_p: true, update_p: true)
        permission.save
      end
    end
  end

  def self.search(search, email, name, profile, employee_id)
    if search.present?
      result = where("name ILIKE ? or email ILIKE ? or profile ILIKE ? or cast(employee_id as text) ILIKE ? or cast(contact_number as text) ILIKE ?" , "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")

      if search.present?
        result.where("email ILIKE ? and name ILIKE ? and profile ILIKE ? and cast(employee_id as text) ILIKE ?", "%#{email}%", "%#{name}%", "%#{profile}%", "%#{employee_id}%")
      end

    elsif email.present? or name.present? or profile.present? or employee_id.present?
      where("email ILIKE ? and name ILIKE ? and profile ILIKE ? and cast(employee_id as text) ILIKE ?" ,  "%#{email}%", "%#{name}%", "%#{profile}%", "%#{employee_id}%")
    else search.blank?
      all
    end
  end
end
