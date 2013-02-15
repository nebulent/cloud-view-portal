module ApplicationHelper
  def link_button (name, path, opts={})
    button_to name, path, {:method => :get}.merge(opts)
  end

  def delete_button (name, path, opts={})
    btn_opts = {
      method: :delete,
      onclick: 'return confirm("Are you sure ?")',
      'class' => 'btn btn-danger btn-small',
      style: 'background: !important; color: !important'
    }
    button_to name, path, opts.merge(btn_opts)
  end

  def collection_select_tag(collection, current_id, options={})
    entries = options_from_collection_for_select(collection, "id", "name", current_id)
    select_tag collection.first.class.to_s.underscore, entries, options
  end
end
