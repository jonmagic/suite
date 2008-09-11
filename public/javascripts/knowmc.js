// Bind the show action to each row in the client list div
jQuery(document).ready(function(){

  // clients index page, click to open client function
  jQuery("#clients tr.client").each(function(){
    jQuery(this).bind("click",function(){
      var number = jQuery(this).attr("alt");
      // jQuery("#client").load("/clients/"+number);
      window.location = "/clients/"+number;
    });
  });
  
  // client edit page, show or hide form elements based on whether its a company
  if (jQuery("#client h3.is_a_company input").attr("checked")) { 
    jQuery("#client h2.person_name").addClass("hide")
    jQuery("#client h3.company_select").addClass("hide")
  } else {
    jQuery("#client h2.company_name").addClass("hide")
  };
  jQuery("#client h3.is_a_company input").click( function() {
    if (jQuery("#client h3.is_a_company input").attr("checked")) {
     jQuery("#client h2.person_name").addClass("hide")  
    jQuery("#client h2.company_name").removeClass("hide")     
    jQuery("#client h3.company_select").addClass("hide")
    } else {
     jQuery("#client h2.person_name").removeClass("hide")
     jQuery("#client h2.company_name").addClass("hide")     
     jQuery("#client h3.company_select").removeClass("hide")
    }
  });
  
  // client edit page, place titles in form elements if they are empty, and on click select all
  jQuery("#names input[@type=text]").each( function() {
    if (jQuery(this).val() == "") {
      jQuery(this).addClass("blur");      
    }
    jQuery(this).hint();
  });
});