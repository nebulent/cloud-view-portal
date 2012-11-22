require 'spec_helper'

describe RemoteSession do

  it { should belong_to(:connection) }
  it { should validate_presence_of(:connection) }

end
