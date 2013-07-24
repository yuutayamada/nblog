ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    if fileInfomation.length
      this.renderArticles(userConfig.article.limit)
  renderArticles: (limit)->
    fileInfomation[0...limit].forEach (info, index) ->
      html = info["file"]
      time = info["date"]
      modified = "<time datetime='#{time}'>" + time + "</time>"
      filename = html.replace("public/", "")
      id   = index
      name = filename.replace("/", "-")
      prev = if id == 0 then "" else "<a href='##{id-1}'>Previous</a>"
      next = "<a href='##{id+1}'>Next</a>"
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
