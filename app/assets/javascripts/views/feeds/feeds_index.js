NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({
  template: JST['feeds/index'],
  className: "feeds",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addFeed);
    this.collection.each( this.addFeed.bind(this) );
  },

  addFeed: function (feed) {
    this.addSubview(
      "ul.feeds-list",
      new NewsReader.Views.FeedsIndexItem({ model: feed })
    );
  },

  render: function () {
    this.$el.html(this.template({ feeds: this.collection }));
    this.attachSubviews();
    return this;
  },
});
