jQuery(document).ready(function(){
  // devices index page, click to open device function
  jQuery("#devices tr.device").each(function(){
    jQuery(this).bind("click",function(){
      var number = jQuery(this).attr("alt");
      window.location = "/devices/"+number;
    });
  });

  // device edit page, place titles in form elements if they are empty, and on click select all
  jQuery("#device input[@type=text]").each( function() {
    if (jQuery(this).val() == "") {
      jQuery(this).addClass("blur");      
    }
    jQuery(this).hint();
  });

});