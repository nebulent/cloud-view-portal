window._cvp ?= {}
c = window._cvp

c.initLogViewer = ($elem)->
  dataUrl = window.location.pathname
  dataSource = new kendo.data.DataSource({
    transport:
      read:
        url: dataUrl
        dataType: "json"
    pageSize: 30
  })

  $elem.kendoGrid({
    dataSource: dataSource
    navigatable: true
    columns: [
      {field: "level", title: "Level"},
      {field: "entity", title: "Entity"},
      {field: "name", title: "Event"},
      {field: "message", title: "Message"},
      {field: "created_at", title: "Created at"},
      {field: "user_id", title: "User ID"}]
    sortable: {
      mode: "single",
      allowUnsort: false
    },
    scrollable: false,
    pageable: true
  })
