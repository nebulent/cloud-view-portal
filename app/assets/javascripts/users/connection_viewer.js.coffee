window._cvp ?= {}
c = _cvp

c.initUserConnectionViewer = ($e)->
  $e.kendoGrid({
    scrollable: false
    pageable: true
    navigatable: true
    filterable: true
  })
