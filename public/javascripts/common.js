// set div heights, including on resize
$(document).ready(function() {
  function resize(){
    var height = $(window).height();
    var width = $(window).width();
    $("#sidebar").css({height: height - 65});
    $("#center").css({width: width - 256})
  };  
  resize();
  $(window).bind('resize', function(){
    resize();
  });
});

// add borders and backgrounds to buttons
$(document).ready(function() {
  $("#header a").addClass("header-button-itu");
  $("#footer a").addClass("footer-button-itu");
});

function buildTables(){
  // table style 1, inspired by itunes
  // setup my header
  $("table.itu th").each(function(){
    var text = $(this).text();
    $(this).text("");
    $(this).append("<div>"+text+"</div>");
    $(this).addClass("remove-margins-padding");
  });
  // wrap my content with hrefs
  $("table.itu td").each(function(){
    $(this).addClass("remove-margins-padding");
  });
  // add my even odd classes to rows
  var rowClass = "even";
  $("table.itu tr").each(function(){
    $(this).addClass(rowClass);
    rowClass = (rowClass == 'even' ? 'odd' : 'even');      
  });
  // setup my row hover
  $("table.itu tr").hover(function(){
    $(this).addClass("table-row-selected");
  }, function(){
    $(this).removeClass("table-row-selected");
  });
  // table style 2, inspired by mail.app
  $("table.m tr").each(function(){
    $("td:first", this).addClass("first");
  });
  $("table.m tr").each(function(){
    $("th:first", this).addClass("first");
  });
  // add padding where necessary
  $("#center div.ui-tabs-panel table.itu").wrap("<div></div>").parent().addClass("ui-tabs-panel-padding");
}

// build my tables
$(document).ready(function() {
  buildTables()
});

    
// Cool time function for parsing UTC 8601 time formats
Date.from_iso8601 = function(string){
    var regexp = "([0-9]{4})(-([0-9]{2})(-([0-9]{2})" +
    "(T([0-9]{2}):([0-9]{2})(:([0-9]{2})(\.([0-9]+))?)?" +
    "(Z|(([-+])([0-9]{2}):([0-9]{2})))?)?)?)?";
    var d = string.match(new RegExp(regexp));

    var offset = 0;
    var date = new Date(d[1], 0, 1);

    if (d[3]) date.setMonth(d[3] - 1);
    if (d[5]) date.setDate(d[5]);
    if (d[7]) date.setHours(d[7]);
    if (d[8]) date.setMinutes(d[8]);
    if (d[10]) date.setSeconds(d[10]);
    if (d[12]) date.setMilliseconds(Number("0." + d[12]) * 1000);
    if (d[14]) {
        offset = (Number(d[16]) * 60) + Number(d[17]);
        offset *= ((d[15] == '-') ? 1 : -1);
    }

    offset -= date.getTimezoneOffset();
    return date;

// time = (Number(date) + (offset * 60 * 1000));
// this.setTime(Number(time));
}

$.fn.hint = function () {
  return this.each(function (){
    // get jQuery version of 'this'
    var t = jQuery(this); 
    // get it once since it won't change
    var title = t.attr('title'); 
    // only apply logic if the element has the attribute
    if (title) { 
      // on blur, set value to title attr if text is blank
      t.blur(function (){
        if (t.val() == '') {
          t.val(title);
          t.addClass('blur');
        }
      });
      // on focus, set value to blank if current value 
      // matches title attr
      t.focus(function (){
        if (t.val() == title) {
          t.val('');
          t.removeClass('blur');
        }
      });
 
      // clear the pre-defined text when form is submitted
      t.parents('form:first()').submit(function(){
          if (t.val() == title) {
              t.val('');
              t.removeClass('blur');
          }
      });
 
      // now change all inputs to title
      t.blur();
    }
  });
}

function gup( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}