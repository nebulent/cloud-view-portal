function randString() {
  var text = '';
  var possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  for(var i=0; i < 5; i++)
  {
      text += possible.charAt(Math.floor(Math.random() * possible.length));
  }

  return text;
}

function createRandomData(number) {
  var data = [];
  var one_date = {};
  for (var i=0; i < number; i++)
  {
    var one_date={
      level: randString(),
      entity: randString(),
      event: randString(),
      message: randString(),
      created_at: randString(),
      user_id: randString()
    };
    data.push(one_date);
  }
  return data;
}

$(document).ready(function(){

  $("#grid").kendoGrid({
    columns:[
      {
        field: "level",
        title: "Level"
      },
      {
        field: "entity",
        title: "Entity"
      },
      {
        field: "event",
        title: "Event"
      },
      {
        field: "message",
        title: "Message"
      },
      {
        field: "created_at",
        title: "Created at"
      },
      {
        field: "user_id",
        title: "User ID"
      }
    ],
    sortable: {
      mode: "single",
      allowUnsort: false
    },
    scrollable: false,
    pageable: true,
    dataSource: {
      pageSize: 15,
      data: createRandomData(20)
      
    }
  });
});
