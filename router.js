var AppRouter = Backbone.Router.extend({
  routes: {
    '': 'home',
    'index.html': 'home',
    ':level': 'blockGrid'
  },
  home : function() {},
  blockGrid : function(level) {
    grid(level); // Calling grid function
  }
});

$(document).ready(function() {
  var appRouter = new AppRouter(); // Router initialization
  Backbone.history.start(); // Backbone start
});

// Applying color for grid based on level.
function grid(level) {
  var id = (isFinite(level)) ? level : articleView.getFileId(level);
  articleView.renderArticle(id);
  window.scrollTo(10,000);
}
