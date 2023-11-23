require 'rails_helper'
require 'requests_helper'
RSpec.describe TeamMembersController do
	  let(:company) { build(:company) }
  before(:each) do 
	  @company = create(:company, id: 111115, name: "xsdfghjkllkjhgkjhgfyz", location: "indore")
	  @role = Role.create(name:"admin")
	  @team_member = create(:team_member, email:"xyzz@gmail.com", role_id: @role.id, password: 123456, company_id: 111115)
	  sign_in(@team_member)
  end

	describe 'GET index' do
		it 'assigns @TeamMembers' do
			get 'index'
			expect(response).to be_successful
			expect(response.code).to eq('200')
		end
	end
end
