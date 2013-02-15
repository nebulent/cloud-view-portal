$ ->
  $('select#organization').bind 'change', ->
    $(@).parent().submit()
