require 'spec_helper'

describe User do
  it 'should have a valid factory' do
    attrs = FactoryGirl.attributes_for :user
    user = User.new attrs
    user.should be_valid
  end

  it { should belong_to(:organization) }
  it { should have_and_belong_to_many(:connections) }
end
