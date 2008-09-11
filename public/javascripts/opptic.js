jQuery(document).ready(function(){
  // tickets index page, click to open ticket function
  jQuery("#tickets tr.ticket").each(function(){
    jQuery(this).bind("click",function(){
      var number = jQuery(this).attr("alt");
      window.location = "/tickets/"+number;
    });
  });

});