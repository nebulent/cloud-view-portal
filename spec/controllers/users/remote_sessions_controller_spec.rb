require 'spec_helper'

describe Users::RemoteSessionsController do

  let (:session_attrs) { { host: '127.0.0.1', port: 5300, id: rand(100)} }
  let (:dummy_session) { stub(session_attrs) }
  let (:dummy_terminal) { stub(id: rand(100), create_session: dummy_session) }
  before(:each) { Terminal.stub(:find).and_return(dummy_terminal) }

  context '#create' do
    it 'should find the terminal' do
      Terminal.should_receive(:find).with(dummy_terminal.id.to_s)
      post :create, term_id: dummy_terminal.id
    end

    it 'should create a session on this terminal' do
      dummy_terminal.should_receive(:create_session)
      post :create, term_id: dummy_terminal.id
      JSON.parse(response.body).should == session_attrs.stringify_keys
    end
  end

  context '#destroy' do
    before (:each) do
      RemoteSession.stub(:find).and_return(dummy_session)
      dummy_session.stub(:destroy)
    end

    it 'should find the requested session' do
      RemoteSession.should_receive(:find).with(dummy_session.id.to_s)
      post :destroy, id: dummy_session.id
    end

    it 'destroy the session' do
      dummy_session.should_receive(:destroy)
      post :destroy, id: dummy_session.id
    end
  end

end
