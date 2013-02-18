window._cvp ?= {}
c = _cvp

c.initUserConnectionViewer = ($e)->
  $e.kendoGrid({
    dataSource: {
      pageSize: 10
    }
    columns: [
      "Name",
      "Terminal",
      "Protocol",
      "User",
      "Port"]
    scrollable: false
    pageable: true
    navigatable: true
    filterable: true
  })
