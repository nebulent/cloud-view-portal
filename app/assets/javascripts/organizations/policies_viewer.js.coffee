window._cvp ?= {}
c = _cvp

c.initPoliciesViewer = ($e)->
  $e.kendoGrid({
    dataSource: {
      pageSize: 10
      group: { 
        field: "User"
      }
    }
    columns: [
      "User",
      "Terminal",
      "Connection",
      "Delete"]
    groupable: true
    scrollable: false
    pageable: true
    navigatable: true
    sortable: true
  })
