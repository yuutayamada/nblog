ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInformation.length
      this.renderArticle(0) # show latest article
  renderArticle: (index) ->
    file = fileInformation[index]
    filename = "/articles/" + file["name"]
    id   = index
    name = file["name"]
    this.hideArticles()
    if $("##{id}").size() == 0
      $.when($.get(filename)).done((articleHtml) ->
        content = "<article id='#{id}' class='article' name='#{name}'>" +
          articleHtml + "</article>"
        $.when($("#article").append(content)).done(->
          thisArticle = $(this).find("[name='#{name}']")
          articleView.appendHeader(thisArticle, file, id)
          articleView.prettify(thisArticle)
        )
      )
    else
      $("##{id}").show()
  appendHeader: (thisArticle, file, id) ->
    header = "<header class='header'></header>"
    time = file["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    link = articleView.createLink(id)
    direction = "" + link.prev + link.next
    thisArticle.find("h1").wrap(header)
    thisArticle.find("header").prepend(modified + direction)
  prettify: (thisArticle) ->
    pre = thisArticle.find("pre")
    code = thisArticle.find("code")
    color = "#EEEEEE"
    pre.css("background", color)
    pre.attr("class", "prettyprint")
    code.css("background", color)
    code.attr("class", "prettyprint")
  createLink: (id) ->
    isId = (id) ->
      if fileInformation[id] and !(fileInformation.length == id)
        true
      else
        null
    prev_id = Number(id) - 1
    next_id = Number(id) + 1
    prev = if isId(prev_id) then "<a href='##{prev_id}'> Previous </a>" else ""
    next = if isId(next_id) then "<a href='##{next_id}'> Next </a>" else ""
    { prev: prev, next: next }
  hideArticles: ->
    $(".article").hide()
})

window.articleView = new ArticleView({el: '#article'})
