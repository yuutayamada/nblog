user = userConfig.coderwall.github_account
if user
  class CoderwallView extends Backbone.View
    el: "#sidebar"
    tagName: "div"
    initialize: ->
      @render()
    render: =>
      $(@el).html """
      <div class='coderwall'>Coderwall<div id='coderwall-img'></div></div>
      """
      url = "http://www.coderwall.com/"
      coderwallJSONurl = url + user + ".json?callback=?"
      height = width = 65
      $.getJSON(coderwallJSONurl, (coderwall) ->
        $.each(coderwall.data.badges, (i, item) ->
          $("<img/>").attr("src", item.badge)
            .attr("float", "left")
            .attr("title", item.name + ": " + item.description)
            .attr("alt", item.name)
            .attr("height", height)
            .attr("width", width)
            .appendTo("#coderwall-img")
            .hover(-> $(this).css("opacity","1.0")) # 0.6?
            .click(-> window.location = url + user)
        )
      )

  coderwallView = new CoderwallView
