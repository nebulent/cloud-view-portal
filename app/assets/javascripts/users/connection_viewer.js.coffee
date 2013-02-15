window._cvp ?= {}
c = _cvp

c.initUserConnectionViewer = ($e)->
  console.log 'hui'
  $e.kendoGrid({
    scrollable: false
    pageable: true
    navigatable: true
    filterable: true
    })
