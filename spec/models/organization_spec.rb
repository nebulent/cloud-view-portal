require 'spec_helper'

describe Organization do

  it { should belong_to(:head) }
  it { should have_many(:users) }
  it { should have_many(:terminals) }
  it { should validate_presence_of(:name) }

end
