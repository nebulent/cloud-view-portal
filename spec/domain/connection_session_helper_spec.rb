require_relative '../../app/domain/connection_session_helper'

unless defined?(ProxyDaemon)
  ProxyDaemon = Object.new
end

describe ConnectionSessionHelper do

  let (:remote_session) { stub }
  let (:session) { stub(:session, update_attributes: true,
                                  destroy: true) }
  let (:connection) { stub(:connection, create_session: session) }
  let (:subject) { ConnectionSessionHelper.new(connection) }
  let (:daemon) { stub(:daemon, start!: true,
                                stop!: true,
                                host: '127.0.0.1',
                                port: 5900) }
  before { ProxyDaemon.stub(new: daemon) }

  context '#create_session' do
    it 'should instanciate a proxy daemon' do
      ProxyDaemon.should_receive :new, with: connection
      subject.create_session
    end

    it 'should create a remote_session' do
      connection.should_receive :create_session
      subject.create_session
    end

    it 'should update remote_session with daemon data' do
      session.should_receive(:update_attributes, with: {
        pid: daemon.start!,
        host: daemon.host,
        port: daemon.port
      })
      subject.create_session
    end

    it 'should return the session' do
      subject.create_session.should == session
    end
  end

  context '#destroy_session' do
    let (:subject) { ConnectionSessionHelper.new(connection, session) }

    it 'should kill the daemon' do
      daemon.should_receive :stop!
      subject.destroy_session
    end

    it 'should remove remote_session from database' do
      session.should_receive :destroy
      subject.destroy_session
    end

    it 'should not do anything if session is nil' do
      helper = ConnectionSessionHelper.new(connection)
      ProxyDaemon.should_not_receive(:new)
      helper.destroy_session
    end
  end

end
