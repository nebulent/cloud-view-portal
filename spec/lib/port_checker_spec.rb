require 'socket'
require_relative '../../lib/port_checker'

describe PortChecker do

  it 'should detect a closed port' do
    s = TCPServer.new('127.0.0.1', 8888)
    PortChecker.open?(8888).should == false
    s.close
  end

  it 'should detect an open port' do
    PortChecker.open?(64000).should == true
  end

  it 'should generate a random open port' do
    port = PortChecker.rand_open
    PortChecker.open?(port).should == true
  end

end
