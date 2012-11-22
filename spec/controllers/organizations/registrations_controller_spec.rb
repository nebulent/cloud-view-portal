require 'spec_helper'

describe Organizations::RegistrationsController do

  it 'should redirect to dashboard after sign up' do
    subject.after_sign_up_path_for(stub).should == organizations_dashboard_path('index')
  end

  it 'should redirect to dashboard after sign in' do
    subject.after_sign_in_path_for(stub).should == organizations_dashboard_path('index')
  end

end
