var AppRouter = Backbone.Router.extend({
  routes: {
    '': 'home',
    'index.html': 'home',
    ':level': 'blockGrid'
  },
  home : function() {},
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
  articleView.renderArticle(id);
  window.scrollTo(10,000);
}
