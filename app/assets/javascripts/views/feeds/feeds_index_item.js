NewsReader.Views.FeedsIndexItem = Backbone.View.extend({
  template: JST['feeds/index_item'],
  className: "feed-index-item",
  tagName: "li",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button.feed-delete-button": "delete"
  },

  delete: function(event) {
    this.model.destroy(
      { success: this.remove.bind(this) }
    );
  },

  render: function () {
    this.$el.html(this.template({ feed: this.model }));

    return this;
  },
});
