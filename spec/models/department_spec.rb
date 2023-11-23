require 'rails_helper'

RSpec.describe Department, type: :model do
  let(:department) {build(:department)}
  describe "validation" do 
    it "is valid with valid attributes" do
      expect(department).to be_valid
    end

    it "is invalid with nill attributes" do
      department = Department.new(name: nil, company_id: nil)
      expect(department).to be_invalid
    end

    it "is invalid with nill name attributes" do
      department = Department.new(name: "RJ", company_id: nil)
      expect(department).to be_invalid
    end

    it "is invalid with nill company_id attributes" do
      department = Department.new(name: nil , company_id: 107)
      expect(department).to be_invalid
    end
  end

  describe "Department" do
    it "should have many designations" do
      should have_many(:designations)
    end 
    it "should belong to company" do
      should belong_to(:company)
    end
  end 
end
