TrelloClone.Views.BoardsIndex = Backbone.View.extend({

  template: JST['boards/index'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },



  render: function () {
    this.$el.html(this.template({ board: this.model }));

    return this;
  }



});
