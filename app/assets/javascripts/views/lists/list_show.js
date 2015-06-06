TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  tagName: "li",
  className: "list",

  template: JST['lists/show'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.cards(), "add", this.addCard);
    this.listenTo(this.model.cards(), "reset", this.addCards);
    this.addCards();
  },

  addCards: function() {
    this.model.cards().each(this.addCard, this);
  },

  addCard: function(card) {
    this.addSubview(
      ".cards-list",
      new TrelloClone.Views.CardShow({ model: card })
      );
  },


  render: function () {
    this.$el.html(this.template({ list: this.model }));
    this.attachSubviews();

    return this;
  }


});
