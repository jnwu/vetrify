function scrollToListener (anchor, target, time) {
  $(anchor).click(function(e) {
    e.preventDefault();
    $("body").scrollTo( $(target), time );
  });
}

$(function () {
  if ( $(".about") ) {
    scrollToListener(".about" , ".m-about", 600);
  }
});
