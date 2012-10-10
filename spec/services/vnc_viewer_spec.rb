require_relative '../../app/services/vnc_viewer'

describe VncViewer do

  it 'should provide a viewer link for a terminal' do
    terminal = stub(username: 'jora', port: 6800)
    viewer = VncViewer.new(terminal)
    viewer.connect_link.should_not be_nil
  end

end
