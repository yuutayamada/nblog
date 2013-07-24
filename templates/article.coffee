ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInfomation.length
      this.renderArticle(0) # show latest article
  renderArticle: (index) ->
    info = fileInfomation[index]
    length = fileInfomation.length - 1
    html = info["file"]
    time = info["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    filename = html.replace("public/", "")
    id   = index
    name = filename.replace("/", "-")
    prev = if !(index == 0) then  "<a href='##{id-1}'> Previous </a>" else ""
    next = if !(index == length) then "<a href='##{id+1}'> Next </a>" else ""
    direction = "" + prev + next
    if $("##{id}").size() == 0
      $.when($.get(filename)).done((articleHtml) ->
        content = "<article id='#{id}' class='article' name='#{name}'>" +
          articleHtml + "</article>"
        $.when($("#article").append(content)).done(->
          header = "<header class='header'></header>"
          thisArticle = $(this).find("[name='#{name}']")
          thisArticle.find("h1").wrap(header)
          thisArticle.find("header").prepend(modified)
          thisArticle.find("header").prepend(direction)
        )
      )
})
view = new ArticleView({el: '#article'})
