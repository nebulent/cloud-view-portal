require "spec_helper"

describe TerminalsController do

  describe 'get #index' do
    it "should have a list of all terminals" do
      get :index
      terminals = Terminal.all
      assigns(:terminals).should == terminals
    end

    it "should render index view" do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'post #create' do
    let (:terminal_attrs) { FactoryGirl.attributes_for(:terminal).stringify_keys }

    it "should add to database if valid" do
      post(:create, terminal: terminal_attrs)
      Terminal.last.attributes.should include(terminal_attrs)
    end

    it "should generate flash errors if invalid" do
      terminal_attrs[:name] = nil
      post(:create, terminal: terminal_attrs)
      flash.now[:error].should_not be_nil
    end
  end

  describe 'get #edit' do
    let (:terminal) { FactoryGirl.create(:terminal) }

    it 'have the terminal assigned' do
      get :edit, id: terminal.id
      assigns(:terminal).should == terminal
    end

    it 'should render edit template' do
      get :edit, id: terminal.id
      response.should render_template(:edit)
    end
  end

  describe 'put #update' do
    let (:terminal) { FactoryGirl.create(:terminal) }

    it "should update if valid" do
      terminal.name = 'obviously valid'
      put :update, id: terminal.id, terminal: terminal.attributes
      Terminal.find(terminal.id).should == terminal
    end

    it "should generate flash errors if invalid" do
      terminal.name = nil
      put(:update, id: terminal.id, terminal: terminal.attributes)
      flash.now[:error].should_not be_nil
    end

    it "should render the edit template" do
      put(:update, id: terminal.id, terminal: terminal.attributes)
      response.should render_template(:edit)
    end
  end

  describe 'delete #destroy' do
    let (:terminal) { FactoryGirl.create(:terminal) }

    it "should delete a terminal" do
      delete(:destroy, id: terminal.id)
      expect {
        Terminal.find(terminal.id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "should redirect to index" do
      delete(:destroy, id: terminal.id)
      response.should redirect_to(terminals_path)
    end
  end

end
