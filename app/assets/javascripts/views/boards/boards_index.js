TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({

  template: JST['boards/index'],

  initialize: function (options) {
    this.listenTo(this.collection, "reset", this.render);
  },



  render: function () {
    this.$el.html(this.template());

    return this;
  }



});
