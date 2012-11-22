require 'spec_helper'

describe Organizations::ApplicationController do

  before { get '/organizations/dashboard/index' }

  it 'should require authentication' do
    # should redirect
  end

  it 'should fetch organization from head' do
    assigns[@organization].should == head.organization
  end

end
