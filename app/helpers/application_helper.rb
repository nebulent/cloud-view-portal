module ApplicationHelper

  def terminal_connect_link (terminal)
    link_to terminal.name, "/clients/vnc/index.html?term_id=#{terminal.id}"
  end

end
