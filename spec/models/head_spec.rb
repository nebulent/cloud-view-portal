require 'spec_helper'

describe Head do
  it { should have_one(:organization) }
  it { should accept_nested_attributes_for(:organization) }
  it { should validate_presence_of(:organization) }
end
