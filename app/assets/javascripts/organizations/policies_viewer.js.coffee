window._vam ?= {}
c = _vam

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
      "Protocol",
      "ConnectionUsername",
      "Port",
      "Delete"]
    groupable: true
    scrollable: false
    pageable: true
    navigatable: true
    sortable: true
  })
