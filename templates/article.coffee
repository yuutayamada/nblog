ArticleView = Backbone.View.extend({
  tagName: 'div'
  initialize: ->
    this.fileInfo = this.getFileUrls()
    if this.fileInfo.length
      this.renderArticle(0, this.fileInfo) # show latest article
  renderArticle: (index, fileInfo) ->
    if index or index == 0
      file = fileInfo[index]
      file_path = "/articles/" + file["name"]
      id   = index
      name = file["name"]
      this.hideArticles()
      if $("##{id}").size() == 0
        $.when($.get(file_path)).done((articleHtml) ->
          content = "<article id='#{id}' class='article' name='#{name}'>" +
            articleHtml + "</article>"
          $.when($("#article").append(content)).done(->
            thisArticle = $(this).find("[name='#{name}']")
            articleView.appendHeader(thisArticle, file, id, fileInfo)
            articleView.prettify(thisArticle)
          )
        )
      else
        $("##{id}").show()
    this
  getFileUrls: ->
    urls = $("#article").attr("value")
    fileInfo = jQuery.parseJSON(urls)
  getFileId: (name) ->
    id = 0
    try
      this.fileInfo.forEach((file, index)->
        if !(this.fileInfo.length == index)
          if file["name"] == name
            id = index
            throw false
      )
    catch error
      if error
        throw error
      else
        id
  appendHeader: (thisArticle, file, id, fileInfo) ->
    header = "<header class='header'></header>"
    time = file["date"]
    modified = "<time datetime='#{time}'>" + time + "</time>"
    link = articleView.createLink(id, fileInfo)
    direction = "" + link.prev + link.next
    thisArticle.find("h1").wrap(header)
    thisArticle.find("header").prepend(modified + direction)
  prettify: (thisArticle) ->
    pre = thisArticle.find("pre")
    code = thisArticle.find("code")
    if pre.size() != 0 or code.size() != 0
      color = "#EEEEEE"
      pre.css("background", color)
      code.css("background", color)
      pre.attr("class", "prettyprint")
      code.attr("class", "prettyprint")
      prettyPrint()
  createLink: (id, fileInfo) ->
    isId = (id) ->
      if fileInfo[id] and !(fileInfo.length == id)
        true
      else
        null
    prev_id = Number(id) - 1
    next_id = Number(id) + 1
    prev = if isId(prev_id) then "<a href='##{prev_id}'> Previous </a>" else ""
    next = if isId(next_id) then "<a href='##{next_id}'> Next </a>"     else ""
    { prev: prev, next: next }
  hideArticles: ->
    $(".article").hide()
})

window.articleView = new ArticleView({el: '#article'})
