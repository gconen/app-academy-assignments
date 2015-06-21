TrelloClone.Views.CardShow = Backbone.View.extend({
  tagName: "li",
  className: "card",
  attributes: function () {
    return {
      "data-card-id": this.model.get("id"),
    };
  },

  template: JST['cards/show'],

  render: function () {
    this.$el.html(this.template({ card: this.model }));

    return this;
  }

});
