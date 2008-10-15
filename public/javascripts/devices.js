// Load devices into the sidebar
$(document).ready(function() {
  $.getJSON("/devices", function(data){
    $.each(data, function(i, object){
      $("<a></a>").attr("href", "/devices/"+object.device.id).text(object.device.name).appendTo($("<li></li>").attr("alt", object.device.id).appendTo("#devices"));
    });
    // Get the device id
    var device_id = $("#device table").attr("alt");
    // Create Edit or Save link
    if ($("#device_details").length > 0) {
      if ($("#device table").attr("edit") != "edit") {
        $("#footer div.col2").append("<a href='/devices/"+device_id+"/edit' class='edit_device col2_button1'>Edit</a>");
      }else{
        $("#footer div.col2").append("<a href='#' class='edit_device active col2_button1'>Save</a>");
        $("#footer a.edit_device").bind("click", function(){
          // save form
          $("#device input[type=submit]").click();
        });
      };
    };
    // Add selected class to selected item
    $("#sidebar li").each(function(){
      if ($(this).attr("alt") == device_id) {
        $(this).addClass("selected");
        $("ul#devices").scrollTo(this);
      };
    });
  });
});

// Load other content and create tabs
$(document).ready(function() {
  $("#device_content > ul").tabs();
});