require 'spec_helper'

describe Connection do
  it { should belong_to(:terminal) }
  it { should have_many(:remote_sessions) }
  it { should have_and_belong_to_many(:users) }
  it { should validate_presence_of(:credentials) }
  it { should validate_presence_of(:port) }

  it 'should be able to be converted to string' do
    subject.should respond_to(:to_s)
  end

  it 'should provide the terminal host address' do
    subject.stub terminal: stub(uri: 'whatever')
    subject.host.should == subject.terminal.uri
  end

  it 'should be able to create a remote session' do
    rs_stub = stub(create: nil)
    subject.stub remote_sessions: rs_stub
    rs_stub.should_receive :create, with: { port: subject.port }
    subject.create_session
  end

end
