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
  
  // Setup all my footer buttons
  var ticket_id = $("#ticket").attr("alt");
  // if #ticket div exists
  if ($("#ticket").length > 0) {
    // if edit attribute exists on ticket div
    if ($("#ticket").attr("edit") != "edit") {
      // append an edit button to our footer
      $("#footer div.col2").append("<a href='/tickets/"+ticket_id+"/edit' class='edit_ticket'>Edit</a>");
      // if this ticket is NOT completed
      if ($("#ticket").attr("completed") == "") {
        // append a Complete button to our footer
        $("#footer div.col2").append("<a href='#' class='complete_ticket'>Complete</a>");
      // otherwise
      }else{
        // set the hidden complete field value to null
        $("#complete input[type=text]").val("");
        // if ticket is NOT archived
        if ($("#ticket").attr("archived") == "") {
          // append an archive button and a button to open this ticket back up
          $("#footer div.col2").append("<a href='#' class='archive_ticket'>Archive</a>");
          $("#footer div.col2").append("<a href='#' class='complete_ticket'>Open</a>");
        // otherwise
        }else{
          // set the archive value to null
          $("#archive input[type=text]").val("");
          // and append an Un-Archive button to my footer
          $("#footer div.col2").append("<a href='#' class='archive_ticket'>Un-Archive</a>");
        };
        // bind some cliks
        $("#footer a.archive_ticket").bind("click", function(){
          $("#archive input[type=submit]").click();
        });
      };
      // bind some more clicks
      $("#footer a.complete_ticket").bind("click", function(){
        $("#complete input[type=submit]").click();
      });
    // otherwise
    }else{
      // append a save button to my footer and bind some clicks
      $("#footer div.col2").append("<a href='#' class='edit_ticket'>Save</a>");
      $("#footer a.edit_ticket").bind("click", function(){
        $("#ticket input[type=submit]").click();
      });
    };
  };
  
  // Load entries
  var ticketID = $("#ticket").attr("ticket_id");
  var entriesURL = "/tickets/"+ticketID+"/ticket_entries"
  $("#entries").load(entriesURL, function(){
    var newEntryURL = "/tickets/"+ticketID+"/ticket_entries/new";
    $("a.new_entry_link").bind("click", function(){
      $("#new_ticket_entry").load(newEntryURL, function(){
        $("#new_ticket_entry").slideDown(1000);
      });
    });
  });

  // setup tabs
  var $tabs = $("#ticket_content > ul").tabs();
    
  // nice calendar widget
  $("#ticket_active_on").datepicker({
    showOn: "both",
    buttonImage: "/images/calendar.png",
    buttonImageOnly: true
  });

});
