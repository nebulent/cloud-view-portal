require "spec_helper"

describe Terminal do
  it 'should have a valid factory' do
    FactoryGirl.build(:terminal).should be_valid
  end

  describe "validations" do
    before (:each) { FactoryGirl.create :terminal }

    it { should validate_presence_of :name }
    it { should validate_presence_of :uri }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :uri }
  end
end
