NewsReader.Routers.Router = Backbone.Router.extend({
  routes: {
    "": "root"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  root: function () {
    NewsReader.feeds.fetch();
    this.indexView = new NewsReader.Views.FeedsIndex( {
      collection: NewsReader.feeds
    });
    this.$rootEl.html(this.indexView.render().$el);
  },
});
