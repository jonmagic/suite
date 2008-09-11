jQuery.noConflict();

jQuery.fn.hint = function () {
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

var Subform = Class.create({
  lineIndex: 1,
  parentElement: "",

  // rawHTML contains the html to add using the "add" link
  // lineIndex should be the length of the original array
  // parentElement is the id of the div that the subforms attach to
  initialize: function(rawHTML, lineIndex, parentElement) {
    this.rawHTML        = rawHTML;
    this.lineIndex      = lineIndex;
    this.parentElement  = parentElement;
  },

  // parses the rawHTML and replaces all instances of the word
  // INDEX with the line index
  // So the HTML on that rails outputs will be INDEX, but when this
  // is added to the dom it has the correct id
  parsedHTML: function() {
    return this.rawHTML.replace(/INDEX/g, this.lineIndex++);
  },
  
  // handles the inserting of the child form
  add: function() {
    new Insertion.Bottom($(this.parentElement), this.parsedHTML());
  }
});
