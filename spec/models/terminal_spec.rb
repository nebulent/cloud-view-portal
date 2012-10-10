require "spec_helper"

describe Terminal do
  it 'should have a valid factory' do
    FactoryGirl.build(:terminal).should be_valid
  end

  it 'should get the the username from uri' do
    rand_user = SecureRandom.hex(5)
    terminal = FactoryGirl.build :terminal, uri: "vnc://#{rand_user}@host.com"
    terminal.username.should == rand_user
  end

  it 'should get the host from the uri' do
    rand_host = SecureRandom.hex(6) + '.com'
    terminal = FactoryGirl.build :terminal, uri: "vnc://jora@#{rand_host}:7777"
    terminal.host.should == rand_host
  end

  it 'should get the port from the uri' do
    rand_port = (rand * 10000).to_i
    terminal = FactoryGirl.build :terminal, uri: "vnc://jora@host.com:#{rand_port}"
    terminal.port.should == rand_port
  end

  describe "validations" do
    before (:each) { FactoryGirl.create :terminal }

    it { should validate_presence_of :name }
    it { should validate_presence_of :uri }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :uri }
  end
end
