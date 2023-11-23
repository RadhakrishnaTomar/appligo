require 'rails_helper'

RSpec.describe CompaniesController do
	describe 'GET index' do
		it 'assigns @companies' do
			company = Company.create
			get :index
			expect(assign(:companies)).to eq([company])
		end
	end
end