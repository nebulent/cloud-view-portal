require 'spec_helper'

describe Head do
  it 'should have a valid factory' do
    attrs = FactoryGirl.attributes_for :head
    head = User.new attrs
    head.should be_valid
  end

  it { should have_one(:organization) }
  it { should accept_nested_attributes_for(:organization) }
  it { should validate_presence_of(:organization) }
end
