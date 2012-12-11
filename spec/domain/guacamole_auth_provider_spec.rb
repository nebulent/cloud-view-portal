require_relative '../../app/domain/guacamole_auth_provider'

unless defined?(FactoryGirl)
  require 'factory_girl'

  require_relative '../dummy_models'
  require_relative '../factories'
end

describe GuacamoleAuthProvider do
  let (:terminal) { stub FactoryGirl.attributes_for(:terminal) }
  let (:connection) { stub FactoryGirl.attributes_for(:connection).merge({
                            :terminal => terminal,
                            :protocol => :vnc}) }
  let (:user) { stub FactoryGirl.attributes_for(:user) }

  before do
    user.stub :valid_password? => true,
              :connections => [connection]
    User.stub :find_by_email => user
  end

  describe 'should verify user credentials' do
    it 'should auth with valid credentials' do
      expect {
        GuacamoleAuthProvider.user_connections('', '')
      }.to_not raise_error
    end

    it 'should raise error with invalid credentials' do
      user.stub :valid_password? => false
      expect {
        GuacamoleAuthProvider.user_connections('', '')
      }.to raise_error(GuacamoleAuthProvider::InvalidCredentialsError)
    end
  end

  describe 'data structure' do
    let (:data) { GuacamoleAuthProvider.user_connections('','') }

    it 'should have username property' do
      data[:username].should == user.email
    end

    it 'should list all connections in connections property' do
      data[:connections].first.should == {
        name: connection.terminal.uri,
        protocol: connection.protocol,
        host: connection.terminal.uri,
        port: connection.port,
        password: connection.credentials
      }
    end

    it 'should not list ssh connections' do
      connection.stub :protocol => :ssh
      data[:connections].should be_empty
    end
  end
end
