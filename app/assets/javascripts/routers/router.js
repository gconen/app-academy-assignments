NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root",
    "feeds/:id": "feedShow",
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  root: function () {
    NewsReader.feeds.fetch();
    this._swapView(new NewsReader.Views.FeedsIndex( {
      collection: NewsReader.feeds
    }));
  },

  feedShow: function (id) {
    this._swapView(new NewsReader.Views.FeedShow (
      { model: NewsReader.feeds.getOrFetch(id) }
    ));
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
    return view;
  },
});
