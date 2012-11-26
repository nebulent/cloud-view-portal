cache = {}

fetchConnections = (terminal_id, cb)->
  cached = cache[terminal_id]
  return cb(cached) if cached?

  $.getJSON "/organizations/terminals/#{terminal_id}/connections", (data)->
    console.log data, cache
    cache[terminal_id] = data
    cb(data)


updateConnectionChoicesRenderer = ($container)->
  (data)->
    $connections_select = $container.find('#connection')
    $connections_select.children().remove()

    $entry = $('<option></option>')
    for entry in data
      $new_entry = $entry.clone().val(entry.id).text("user: #{entry.user} port: #{entry.port}")
      $connections_select.append $new_entry

$ ->
  $container = $('#policyEditor')
  return unless $container.length

  $user_select = $container.find('#user')
  $terminal_select = $container.find('#terminal')

  $terminal_select.change ->
    fetchConnections $(this).val(), updateConnectionChoicesRenderer($container)

  $terminal_select.trigger 'change'
