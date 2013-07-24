var AppRouter = Backbone.Router.extend({
  routes: {
    '': 'home',
    'index.html': 'home',
    ':level': 'blockGrid'
  },
  home : function() {},
  blockGrid : function(level){
    grid(level); // Calling grid function
  }
});

$(document).ready(function() {
  var appRouter = new AppRouter(); // Router initialization
  Backbone.history.start(); // Backbone start
});

// Applying color for grid based on level.
function grid(level) {
  articleView.renderArticle(level);
  window.scrollTo(10,000);
}

$(document).ready(function() {
  var appRouter = new AppRouter(); // Router initialization
  Backbone.history.start(); // Backbone start
});
