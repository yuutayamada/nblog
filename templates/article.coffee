ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInformation.length
      this.renderArticle(0) # show latest article
  renderArticle: (index) ->
    info = fileInformation[index]
    html = info["file"]
    time = info["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    filename = html.replace("public/", "")
    id   = index
    name = filename.replace("/", "-")
    link = this.createLink(id)
    direction = "" + link.prev + link.next
    this.hideArticles()
    if $("##{id}").size() == 0
      $.when($.get(filename)).done((articleHtml) ->
        content = "<article id='#{id}' class='article' name='#{name}'>" +
          articleHtml + "</article>"
        $.when($("#article").append(content)).done(->
          header = "<header class='header'></header>"
          thisArticle = $(this).find("[name='#{name}']")
          thisArticle.find("h1").wrap(header)
          thisArticle.find("header").prepend(modified + direction)
        )
      )
    else
      $("##{id}").show()
  createLink: (id) ->
    isId = (id) -> if fileInformation[id] then true else null
    prev_id = Number(id) - 1
    next_id = Number(id) + 1
    prev = if isId(prev_id) then "<a href='##{prev_id}'> Previous </a>" else ""
    next = if isId(next_id) then "<a href='##{next_id}'> Next </a>" else ""
    { prev: prev, next: next }
  hideArticles: ->
    $(".article").hide()
})

window.articleView = new ArticleView({el: '#article'})
