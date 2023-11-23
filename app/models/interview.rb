class Interview < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :applicant
  belongs_to :team_member
  
  validates :title, :status , :interview_date, :team_member_id, presence: true

  accepts_nested_attributes_for :comments
  enum status: { pending: 0, scheduled: 1, selected: 2, rejected: 3,
   onHold: 4, notApplicable: 5, notResponding: 6 }

  validate :check_status, on: :create

  def status_color
    if status == 'pending'
      'badge badge-info'
    elsif status == 'scheduled'
      'badge badge-primary'
    elsif status == 'selected'
      'badge badge-success'
    elsif status == 'rejected'
      'badge badge-danger'
    elsif status == 'onHold'
      'badge badge-secondary'
    elsif status == 'notResponding'
      'badge badge-warning'
    elsif status == 'notApplicable'
      'badge badge-dark'
    end
  end

  private

  def applicant
    Applicant.find(applicant_id)
  end

  def check_status
    return unless applicant.interviews.each do |interview|
      if interview.status.include? status
        errors.add(:status, "can't select because you have already #{self.status} Interview")
      end
    end
  end

end
