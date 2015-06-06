TrelloClone.Views.BoardsIndexItem = Backbone.View.extend({
  tagName: "li",
  className: "boards-index-item",

  template: JST['boards/index_item'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },



  render: function () {
    this.$el.html(this.template({ board: this.model }));

    return this;
  }



});
