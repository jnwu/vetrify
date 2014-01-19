function showHideElement( handle, ele )
{
  $( handle ).click( function ()
  {
    event.preventDefault();
    $( this ).children( ele ).toggle();
  });
}

$( function()
{
  if ( $(".m-timeline .position") )
  {
    showHideElement( ".m-timeline .position", "ul" )
  }
});
