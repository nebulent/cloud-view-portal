window._vam ?= {}
c = window._vam

c.initLogViewer = ($elem)->
  dataUrl = window.location.pathname
  dataSource = new kendo.data.DataSource({
    transport:
      read:
        url: dataUrl
        dataType: "json"
    pageSize: 30
    serverPaging: true
    serverFiltering: true
    serverSorting: true
    schema:
      data: 'data'
      total: 'total'
    sort: [{field: "created_at", dir: "desc"}]
  })

  $elem.kendoGrid({
    dataSource: dataSource
    columns: [
      {field: "level", title: "Lvl"},
      {field: "entity", title: "Entity"},
      {field: "name", title: "Event"},
      {field: "message", title: "Message"},
      {field: "created_at", title: "Created at"},
      {field: "user_email", title: "User"}]
    sortable: {
      mode: "single",
      allowUnsort: false
    },
    scrollable: false
    pageable: true
    navigatable: true
    filterable: true
    columnMenu: true
  })
