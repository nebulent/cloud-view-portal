require_relative '../../lib/proxy_daemon'

# For testing in isolation
unless defined?(Rails)
  class ::Rails
    def self.root
      File.absolute_path File.join(File.dirname(__FILE__), '/../../')
    end
  end
end

describe ProxyDaemon do
  let (:terminal) { stub(host: '127.0.0.1', port: 5900) }
  let (:subject) { ProxyDaemon.new(terminal) }

  it 'should have an existing executable' do
    File.exist?(ProxyDaemon.daemon_executable).should == true
  end

  it 'should have terminal address as target' do
    subject.target.should == "#{terminal.host}:#{terminal.port}"
  end

  it 'should bind to a random open port' do
    PortChecker.should_receive(:rand_open).at_least(1)
  end

  it 'should provide its host address' do
    subject.host.should_not be_nil
  end

  context 'when started' do
    before(:each) { subject.start! }

    it { should be_running }

    it 'should be able to stop' do
      subject.stop!
      subject.should_not be_running
    end
  end

  context 'when attached' do
    before(:each) { subject.start! }

    let (:attached_proxy) { ProxyDaemon.new(terminal, stub(:pid => subject.pid)) }

    it 'should report running status' do
      attached_proxy.should be_running
    end

    it 'should be able to stop the process' do
      attached_proxy.stop!
      attached_proxy.should_not be_running
      #subject.should_not be_running TODO: investigate why this fails
    end

    after(:each) { subject.stop! }
  end

  after(:each) { subject.stop! }

end
