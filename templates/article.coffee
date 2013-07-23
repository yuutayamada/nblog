ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInfomation.length
      this.renderArticles(userConfig.article.limit)
  renderArticles: (limit)->
    fileInfomation[0...limit].forEach (info) ->
      html = info["file"]
      time = info["date"]
      modified = "<time datetime='#{time}'>" + time + "</time>"
      filename = html.replace("public/", "")
      id   = filename.replace("/", "-")
      name = id
      $.when($.get(filename)).done((articleHtml) ->
        content = "<article id='#{id}' class='article' name='#{name}'>" +
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
