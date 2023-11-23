module ControllerMacros
  def login_tm
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:team_member]
      team_member = FactoryBot.create(:team_member)
      team_member.confirm!
      sign_in team_member
    end
  end
end