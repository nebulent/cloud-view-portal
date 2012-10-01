require "spec_helper"

describe TerminalsController do
  context "index" do
    before(:each) { get :index }

    it "should have terminals as instance var" do
      terminals = Terminal.all
      assigns(:terminals).should == terminals
    end
  end
end
