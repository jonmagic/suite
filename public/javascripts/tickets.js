$(document).ready(function() {
  // Setup my sidebar, select the section I'm in, etc
  var status = gup("status");
  $("#sidebar ul li a").each(function(){
    if ($(this).attr("class") == status) {
      $(this).parent("li").addClass("selected");
    };
  });
  if (status == "") {
    $("#sidebar ul li a.open").parent("li").addClass("selected");
  };
  // setup tabs
  var $tabs = $("#ticket_content > ul").tabs(function(){
  });
  buildTables();
});

// Setup all my footer buttons
function ticket_state(){
  if ($("#ticket").length > 0) {
    if($("div#ticket").attr("archived") == ""){
      if($("div#ticket").attr("completed") == ""){
        return "open"
      }else{
        return "completed"
      };
    }else{
      return "archived"
    };
  };
};