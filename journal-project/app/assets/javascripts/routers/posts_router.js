JournalApp.Routers.Posts = Backbone.Router.extend({
  routes: {
    "": "root",
    "posts": "postsIndex",
    "posts/new": "postNew",
    "posts/:id/edit(/)": "postEdit",
    "posts/:id(/)": "postShow"
  },

  initialize: function (options) {
    this._$rootEl = options.$rootEl;
    this.posts = options.collection;
  },

  postEdit: function (id) {
    var model = this.posts.getOrFetch(id);
    var view = new JournalApp.Views.PostForm({model: model});
    this._swapView(view);
  },

  postNew: function () {
    var model = new JournalApp.Models.Post();
    var view = new JournalApp.Views.PostForm({model: model});
    this._swapView(view);
  },

  postsIndex: function() {
    this.posts.fetch({ reset: true });
    var view = new JournalApp.Views.PostsIndex({collection: this.posts});
    this._swapView(view);
  },

  postShow: function(id) {
    var model = this.posts.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({model: model});
    this._swapView(view);
  },

  root: function() {
    this._swapView(new JournalApp.Views.Root());
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this._$rootEl.html(newView.render().$el);
  }

});
