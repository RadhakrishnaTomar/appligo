require "rails_helper"
require "requests_helper"

RSpec.describe DesignationsController, type: :controller do
  let(:team_member) { build(:team_member) }
  let(:company) { build(:company) }
  let(:department) { build(:department) }
  let(:designation) { build(:designation) }
  sign_in(@team_member)

  describe "GET index should be successful" do
    it "returns a 200" do
      get 'index'
      expect(response).to be_successful
      expect(response).to have_http_status(:success)
      expect(response.code).to eq('200')
    end
  end
end