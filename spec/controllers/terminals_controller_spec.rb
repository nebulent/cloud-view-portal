require "spec_helper"

describe TerminalsController do

  it "should have a list of all terminals" do
    get :index
    terminals = Terminal.all
    assigns(:terminals).should == terminals
  end

  it "should have a new terminal" do
    get :new
    assigns(:terminal).should be_a_new_record
  end

  xit "should provide the correct terminal to edit" do

  end

  xit "should be able to delete a terminal" do

  end

  context "validation errors" do
    xit "should show them when creating a terminal" do

    end

    xit "should show them when editing a terinal" do

    end
  end

end
