user = userConfig.coderwall.github_account
if user
  coderwall = "http://www.coderwall.com/"
  coderwallJSONurl =coderwall + user + ".json?callback=?"
  height = width = 65
  div = "<div class='coderwall'>Coderwall<div id='coderwall-img'></div></div>"
  $("#sidebar").append(div)
  $(document).ready( ->
    $.getJSON(coderwallJSONurl, (data) ->
      $.each(data.data.badges, (i, item) ->
        $("<img/>").attr("src", item.badge)
          .attr("float", "left")
          .attr("title", item.name + ": " + item.description)
          .attr("alt", item.name)
          .attr("height", height)
          .attr("width", width)
          .appendTo("#coderwall-img")
          .hover(-> $(this).css("opacity","1.0")) # 0.6?
          .click(-> window.location = coderwall + user)
      )
    )
  )
