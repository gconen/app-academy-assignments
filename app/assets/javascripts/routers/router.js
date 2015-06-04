NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root",
    "feeds/:id": "feedShow",
    "feeds/:feedId/*url": "entryShow"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    NewsReader.feeds.fetch();
    this.rootView = new NewsReader.Views.Root();
    this.$rootEl.append(this.rootView.render().$el);
  },

  root: function () {
    // TA: delegate to root view
    this._currentView && this._currentView.remove();
    this._currentView = null;
  },

  feedShow: function (id) {
    this.rootView.setFeed(id);
  },

  entryShow: function (feedId, entryUrl) {
    this.rootView.showEntry(feedId, entryUrl);
  },
});
