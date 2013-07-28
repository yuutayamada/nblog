var AppRouter = Backbone.Router.extend({
  routes: {
    '': 'home',
    'index.html': 'home',
    ':level': 'blockGrid',
    // Matches http://example.com/#post/index.html
    'post/:file_name': 'post'
  },
  home : function() {},
  post : function(file_name) {
    routeToArticle(file_name);
  },
  blockGrid : function(level) {
    routeToArticle(level);
  }
});

$(document).ready(function() {
  var appRouter = new AppRouter(); // Router initialization
  Backbone.history.start(); // Backbone start
});

function routeToArticle(level) {
  var id = (isFinite(level)) ? level : articleView.getFileId(level);
  var fileInfo = articleView.getFileUrls();
  articleView.renderArticle(id, fileInfo);
  window.scrollTo(10,000);
}
