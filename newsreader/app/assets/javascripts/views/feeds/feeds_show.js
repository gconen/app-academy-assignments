NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST['feeds/show'],
  className: "feed",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.entries(), "add", this.addEntry);
    this.model.entries().each(this.addEntry.bind(this));
    this.entryUrl = null;
  },

  events: {
    "click button.refresh": "refresh"
  },

  addEntry: function (entry) {
    this.addSubview(
      "ul.entries",
      new NewsReader.Views.EntryItem({model: entry}),
      true
    );
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model, entryUrl: this.entryUrl }));
    this.attachSubviews();
    return this;
  },

  refresh: function () {
    this.model.fetch();
  },

  setIFrame: function (entryUrl) {
    this.entryUrl = entryUrl;
    this.render();
  }
});
