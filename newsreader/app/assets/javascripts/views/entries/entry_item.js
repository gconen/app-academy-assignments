NewsReader.Views.EntryItem = Backbone.View.extend({
  template: JST['entries/item'],
  className: "entry",
  tagName: "li",

  initialize: function () {
    // TA: unnecessary?
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    this.$el.html(this.template({ entry: this.model }));

    return this;
  },
});
