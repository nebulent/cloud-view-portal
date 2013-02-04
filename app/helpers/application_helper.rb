module ApplicationHelper

  def terminal_connect_link (terminal)
    link_to terminal.name, "/clients/vnc/index.html?term_id=#{terminal.id}"
  end

  def link_button (name, path, opts={})
    button_to name, path, {:method => :get}.merge(opts)
  end

  def delete_button (name, path, opts={})
    btn_opts = {
      method: :delete, confirm: 'Are you sure ?',
      'class' => 'btn btn-danger btn-small',
      style: 'background: !important; color: !important'
    }
    button_to name, path, opts.merge(btn_opts)
  end

end
