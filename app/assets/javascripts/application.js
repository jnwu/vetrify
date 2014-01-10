// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

function addScrollToListener(clicked_element, target_element) {
  document.getElementsByClassName(clicked_element)[0].onclick = function()
  {
    document.getElementsByClassName(target_element)[0].scrollIntoView();
  };
};

window.onload = function () {
  document.getElementsByClassName("about")[0].onclick = function(e)
  {
    event.preventDefault();
    document.getElementsByClassName("m-about")[0].scrollIntoView();
  };
}

