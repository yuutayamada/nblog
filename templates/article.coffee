ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInformation.length
      this.renderArticle(0) # show latest article
  renderArticle: (index) ->
    info = fileInformation[index]
    length = fileInformation.length - 1
    html = info["file"]
    time = info["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    filename = html.replace("public/", "")
    id   = index
    name = filename.replace("/", "-")
    link = this.createLink(id)
    direction = "" + link.prev + link.next
    this.hideArticle()
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
    length = fileInformation.length - 1
    prev = if !(id == 0) then "<a href='##{id-1}'> Previous </a>" else ""
    next = if !(id == length) then "<a href='##{id+1}'> Next </a>" else ""
    { prev: prev, next: next }
  hideArticle: ->
    $(".article").hide()
})

window.articleView = new ArticleView({el: '#article'})
