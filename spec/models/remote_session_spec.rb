require 'spec_helper'

describe RemoteSession do

  before(:all)   { @terminal = FactoryGirl.create :terminal }
  let (:subject) { RemoteSession.new(terminal_id: @terminal.id) }

  it { should belong_to(:terminal) }
  it { should validate_presence_of(:terminal) }

  context 'proxy daemon' do
    let (:daemon) { stub(start!: 20121, stop!: nil, host: '127.0.0.1', port: 21212) }
    before(:each) { ProxyDaemon.stub!(:new).and_return(daemon) }
    before(:each) { subject.save! }

    it 'should launch a proxy upon creation' do
      subject.pid.should == 20121
    end

    it 'should assign proxy host to self' do
      subject.host.should == daemon.host
    end

    it 'should assign proxy port to self' do
      subject.port.should == daemon.port
    end

    it 'should kill the proxy when destroyed' do
      daemon.should_receive(:stop!)
      subject.destroy
    end
  end

end
