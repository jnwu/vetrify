function showHideChild( handle, ele )
{
  $( handle ).click( function ()
  {
    event.preventDefault();
    if ($( this ).children( ele ).is(":hidden")) {
      $( this ).children( ele ).fadeIn(170);
    } else {
      $( this ).children( ele ).fadeOut(170);
    }
  });
}

function showHideGroup( handle, show, hide_list )
{
  $( handle ).click( function ()
  {
    event.preventDefault();
    console.log(hide_list)
    $(show).fadeIn(170);

    hide_list.forEach(function (item) {
      $(item).fadeOut(170);
    });

  });
}

function showAll( handle, ele ) {
  $( handle ).click( function ()
  {
    event.preventDefault();
    if ($( ele ).is(":hidden")) {
      $( ele ).fadeIn(170);
    }
  });
}

$( function()
{
  // Applicants#Show(:id)
  if ( $(".m-timeline") )
  {
    showHideChild( ".m-timeline .position", "ul" );

    if ( $(".m-timeline .filters") ) {
      showHideGroup(".m-timeline .position_filter", "div.position", ["div.education", "div.repo"]);
      showHideGroup(".m-timeline .education_filter", "div.education", ["div.position", "div.repo"]);
      showHideGroup(".m-timeline .github_filter", "div.repo", ["div.education", "div.position"]);
      showAll(".m-timeline .all_filter", ".m-experience");
    }
  }
});
