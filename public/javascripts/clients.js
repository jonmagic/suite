// load my sidebar, select the client we're showing, add an edit button
$(document).ready(function() {
  $.getJSON("/clients", function(data){
    data.sort(function(a,b){
      if (a.client.company == true){
        var x = a.client.name
      }else{
        var x = a.client.lastname
      }
      if (b.client.company == true){
        var y = b.client.name
      }else{
        var y = b.client.lastname
      }
      return ((x < y) ? -1 : ((x > y) ? 1 : 0));
    });
    $.each(data, function(i, object){
      // Setup my class so we can add an icon later
      if(object.client.company == true){
        var type = "company"
      }else{
        var type = "person"
      };
      // Create and then insert new list item, including values and classes
      var list_item = "<li alt='"+object.client.id+"'><a href='/clients/"+object.client.id+"' class='"+type+"'>"+object.client.fullname+"</a></li>";
      $("ul#clients").append(list_item);
    });
    $("input#srch_fld").liveUpdate('ul#clients').focus();
    var client_id = $("div#client h2").attr("alt");
    // Setup my scrollto functionality
    $("#sidebar li").each(function(){
      if ($(this).attr("alt") == client_id) {
        $(this).addClass("selected");
        $("#sidebar").scrollTo(this);
      };
    });
  });
  
});

// setup tabs
$(document).ready(function() {
  $("#client_content > ul").tabs();
  $("#center div.ui-tabs-panel table.itu").wrap("<div></div>").parent().addClass("ui-tabs-panel-padding");
});

$(document).ready(function() {
  $("input#srch_fld").liveUpdate('ul#clients').focus();
});