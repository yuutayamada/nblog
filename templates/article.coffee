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
      header   = "<header class='header'></header>"
      filename = html.replace("public/", "")
      id   = filename.replace("/", "-")
      name = id
      appendArticle = (html) ->
        content = "<article id='#{id}' class='article' name='#{name}'>" +
          html + "</article>"
        $.when($("#article").append(content)).done(->
          $(this).find("[name='#{name}']").find("h1").wrap(header)
          $(this).find("[name='#{name}']").find("header").prepend(modified)
        )
      $.when($.get(filename))
        .done((articleHtml) -> appendArticle(articleHtml))
})
view = new ArticleView({el: '#article'})
