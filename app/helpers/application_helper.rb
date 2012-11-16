module ApplicationHelper

  def terminal_connect_link (terminal)
    link_to terminal.name, "/clients/vnc/index.html?term_id=#{terminal.id}"
  end

  def delete_button (name, path, opts={})
    button_to name, path, opts.merge(method: :delete, confirm: 'Are you sure')
  end

end
