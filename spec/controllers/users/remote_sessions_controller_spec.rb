require 'spec_helper'

describe Users::RemoteSessionsController do

  let (:session_attrs) { { host: '127.0.0.1', port: 5300, id: rand(100)} }
  let (:dummy_session) { stub(session_attrs.merge(connection: stub)) }
  let (:dummy_terminal) { stub(id: rand(100), create_session: dummy_session) }

  context '#create' do
    it 'not necessary to test since this is a prototypic interaction'
  end

  context '#destroy' do
    let (:dummy_helper) { stub(destroy_session: rand(10)) }

    before do
      RemoteSession.stub(:find).and_return(dummy_session)
      ConnectionSessionHelper.stub :new => dummy_helper
    end

    it 'should delegate to ConnectionHelper' do
      ConnectionSessionHelper.should_receive :new,
         with: [dummy_session.connection, dummy_session]
      dummy_helper.should_receive :destroy_session
      post :destroy, id: dummy_session.id
    end

    it 'should render destroy status as json' do
      post :destroy, id: dummy_session.id
      response.body.should == { success: dummy_helper.destroy_session }.to_json
    end
  end

end
