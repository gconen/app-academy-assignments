NewsReader.Views.FeedsForm = Backbone.View.extend({
  template: JST['feeds/form'],
  className: "feed-form",
  tagName: "form",

  initialize: function () {
  },

  events: {
    "click button.submit": "submit"
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));

    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var $url = this.$("input");
    var feed = new NewsReader.Models.Feed({ url: $url.val() });
    feed.save({}, {
      success: NewsReader.feeds.add.bind(NewsReader.feeds, feed),
    });
    $url.val("");
  },
});
