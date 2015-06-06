TrelloClone.Views.CardShow = Backbone.View.extend({
  tagName: "li",
  className: "card",

  template: JST['cards/show'],

  render: function () {
    this.$el.html(this.template({ card: this.model }));

    return this;
  }

});
