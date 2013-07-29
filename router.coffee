AppRouter = Backbone.Router.extend({
  routes:
    '': 'home'
    'index.html': 'home'
    ':level': 'blockGrid'
    # Matches http://example.com/#post/index.html
    'post/:file_name': 'post'
  home : -> null
  post : (file_name) ->
    routeToArticle(file_name)
  blockGrid : (level) ->
    routeToArticle(level)
})

$(document).ready(->
  appRouter = new AppRouter() # Router initialization
  Backbone.history.start() # Backbone start
)

routeToArticle = (level) ->
  id = if (isFinite(level)) then level else articleView.getFileId(level)
  fileInfo = articleView.getFileUrls()
  articleView.render(id, fileInfo)
