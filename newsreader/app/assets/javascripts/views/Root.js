NewsReader.Views.Root = Backbone.CompositeView.extend({
  template: JST['root'],
  className: "container",

  initialize: function () {
    this.indexView = new NewsReader.Views.FeedsIndex(
      { collection: NewsReader.feeds }
    );
    this.addSubview("#index", this.indexView);
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));
    this.attachSubviews();

    return this;
  },

  setFeed: function (id, entryId) {
    var feed = NewsReader.feeds.getOrFetch(id);
    this._currentFeedView && this._currentFeedView.remove();
    this._currentFeedView = new NewsReader.Views.FeedShow({
      model: feed
    });
    this.addSubview("#feed", this._currentFeedView);
  },

  showEntry: function (feedId, entryUrl) {
    if (!this._currentFeedView || this._currentFeedView.model.id !== feedId) {
      this.setFeed(feedId);
    }
    this._currentFeedView.setIFrame(entryUrl);
  },
});
