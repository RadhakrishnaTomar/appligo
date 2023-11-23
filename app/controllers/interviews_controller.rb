class InterviewsController < ApplicationController
  before_action :authenticate_team_member!
  before_action :require_company!
  before_action :load_applicant!, except: %w[assigned_interviews interview_feedback feedback_update data show_data ] 
  before_action :load_resource, only: %w[show edit update destroy]
  before_action :load_team_resource, only: %w[interview_feedback feedback_update]
  # before_action :auth_interview, except: %w(index new create assigned_interviews interview_feedback feedback_update)
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
    @interviews = @applicant.interviews
  end

  def assigned_interviews
    @interviews = current_team_member.interviews
  end

  def show; end

  def interview_feedback; end

  def feedback_update
    if @interview.update(interview_params)
      respond_to do |format|
        format.html { redirect_to assigned_interviews_path, notice: 'Inteview Feedback Submitted!' }
      end
    else
      redirect_to root_path
    end
  end

  def new
    @interview = @applicant.interviews.new
    @interview.comments.build
  end

  def create
    @interview = @applicant.interviews.new(interview_params)
    if @interview.save
      redirect_to applicant_path(@applicant.id), notice: 'Inteview scheduled successfully!'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @interview.update(interview_params)
      redirect_to applicant_path(@applicant.id), notice: 'Interview details updated.'
    else
      render :edit
    end
  end

  def data
  start_date = Time.now
  end_date = 7.days.from_now
  applicants = current_company.applicants
  interviews_data = Interview.joins(:applicant)
                    .where(applicants: { company_id: current_company.id }, interview_date: start_date..end_date)
                    .group("DATE(interview_date)")
                    .count
  date_range = (start_date.to_date...end_date.to_date).map { |date| date.strftime("%d-%b") }
  default_data = Hash[date_range.product([nil])]
  final_data = default_data.merge(interviews_data.transform_keys { |key| key.strftime("%d-%b") })
  render json: final_data
end

  def show_data
  start_date = 1.month.ago
  end_date = Time.now
  applicants = current_company.applicants
  interviews_data = Interview.joins(:applicant)
                    .where(applicants: { company_id: current_company.id }, interview_date: start_date..end_date)
                    .group("DATE(interview_date)")
                    .count
  date_range = (start_date.to_date...end_date.to_date).map { |date| date.strftime("%d-%b") }
  default_data = Hash[date_range.product([nil])]
  final_data = default_data.merge(interviews_data.transform_keys { |key| key.strftime("%d-%b") })
  render json: final_data
end

  private

  def authorize_section
    authorize :Interview
  end

  def interview_params
    params.require(:interview).permit(:title, :team_member_id, :applicant_id, :interview_date, :status,
                                      comments_attributes: %i[id content commentable_id commentable_type team_member_id])
  end

  def load_resource
    @interview = @applicant.interviews.find(params[:id])
  end

  def load_applicant!
    @applicant = current_company.applicants.find(params[:applicant_id])
  end

  def load_team_resource
    @interview = current_team_member.interviews.find(params[:id])
  end

  # def auth_interview
  #   authorize @interview
  # end
end
