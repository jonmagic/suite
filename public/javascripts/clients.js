// load my sidebar, select the client we're showing, add an edit button
$(document).ready(function() {

  $.getJSON("/clients", function(data){
    $.each(data, function(i, object){
      // Setup my class so we can add an icon later
      if(object.client.company == true){
        var type = "company"
      }else{
        var type = "person"
      };
      // Create and then insert new list item, including values and classes
      $("<a></a>").addClass(type).attr("href", "/clients/"+object.client.id).text(object.client.fullname).appendTo($("<li></li>").attr("alt", object.client.id).appendTo("#clients"));
    });
    // Grab the client id for later use
    var client_id = $("#client h2").attr("alt");
    // Add in my Edit and Save buttons
    if ($("#client_content").length > 0) {
      if ($("#client h2").attr("edit") != "edit") {
        $("#footer div.col2").append("<a href='/clients/"+client_id+"/edit' class='edit_client col2_button1'>Edit</a>");
      }else{
        $("#footer div.col2").append("<a href='#' class='edit_client active col2_button1'>Save</a>");
        $("#footer a.edit_client").bind("click", function(){
          // fix form saves so that empty boxes don't get saved :-)
          $("#details input").each(function(){
            if ($(this).attr("value") == '') {
              $(this).parent().parent().remove();
            };
          });
          // save form
          $("#client input[type=submit]").click();
        });
      };
    };
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
});

// client edit page, show or hide form elements based on whether its a company
$(document).ready(function() {
  if ($("#client h3.is_a_company input").attr("checked")) { 
    $("#client h2.person_name").addClass("hide")
    $("#client h3.company_select").addClass("hide")
  } else {
    $("#client h2.company_name").addClass("hide")
  };
  $("#client h3.is_a_company input").click( function() {
    if ($("#client h3.is_a_company input").attr("checked")) {
     $("#client h2.person_name").addClass("hide")  
    $("#client h2.company_name").removeClass("hide")     
    $("#client h3.company_select").addClass("hide")
    } else {
     $("#client h2.person_name").removeClass("hide")
     $("#client h2.company_name").addClass("hide")     
     $("#client h3.company_select").removeClass("hide")
    }
  });

});

// client edit page, place titles in form elements if they are empty, and on click select all
$(document).ready(function() {
  
  $("#names input[@type=text]").each( function() {
    if ($(this).val() == "") {
      $(this).addClass("blur");      
    }
    $(this).hint();
  });

});


$(document).ready(function() {

});