window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $sidebar = $("#sidebar");
    var collection = new JournalApp.Collections.Posts();
    var sidebarView = new JournalApp.Views.PostsIndex({collection: collection});
    collection.fetch({reset: true});
    $sidebar.html(sidebarView.$el);

    var router = new JournalApp.Routers.Posts({
      $rootEl: $("#main"),
      collection: collection
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
