require 'spec_helper'

describe RemoteSession do
  before(:all)   { @terminal = FactoryGirl.create :terminal }
  let (:subject) { RemoteSession.new(terminal_id: @terminal.id) }

  it { should belong_to(:terminal) }
  it { should validate_presence_of(:terminal) }

  context 'proxy daemon' do
    let (:daemon) { stub(:start! => 20121, :stop! => nil) }
    before(:each) { ProxyDaemon.stub!(:new).and_return(daemon) }

    it 'should launch a proxy upon creation' do
      daemon.should_receive(:start!)
      subject.save!
      subject.pid.should == 20121
    end

    it 'should kill the proxy when destroyed' do
      daemon.should_receive(:stop!)
      subject.save!
      subject.destroy
    end
  end

end
