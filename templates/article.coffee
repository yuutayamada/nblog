ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInfomation.length
      this.renderArticle(0) # show latest article
  renderArticle: (index) ->
    info = fileInfomation[index]
    length = fileInfomation
    html = info["file"]
    time = info["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    filename = html.replace("public/", "")
    id   = index
    name = filename.replace("/", "-")
    direction = prev + next
    $.when($.get(filename)).done((articleHtml) ->
      content = direction +
        "<article id='#{id}' class='article' name='#{name}'>" +
        articleHtml + "</article>"
      $.when($("#article").append(content)).done(->
        this.renderHeader(this, time, modified)
      )
    )
  renderHeader: (that, time, modified) ->
    header = "<header class='header'></header>"
    $(that).find("[name='#{name}']").find("h1").wrap(header)
    $(that).find("[name='#{name}']").find("header").prepend(modified)
})
view = new ArticleView({el: '#article'})
