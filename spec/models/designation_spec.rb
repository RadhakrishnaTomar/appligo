require 'rails_helper'

RSpec.describe Designation, type: :model do
  let(:designation) { build(:designation) }
  describe "validation" do 
    it "is valid with valid attributes" do
      expect(designation).to be_valid
    end

    it "is invalid with null attributes" do
      designation = Designation.new(name: nil, department_id: nil)
      expect(designation).to be_invalid
    end    

    it "is invalid with null name attributes" do
      designation = Designation.new(name: nil)
      expect(designation).to be_invalid
    end    

    it "is invalid with null designation_id attributes" do
      designation = Designation.new(department_id: nil)
      expect(designation).to be_invalid
    end    
  end

  describe "Designation" do
    it "should belong to Department" do
      should belong_to(:department)
    end
  end 
end
