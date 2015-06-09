TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  tagName: "li",
  className: "list",
  attributes: function () {
    return { "data-list-id": this.model.get("id") };
  },

  template: JST['lists/show'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.cards(), "reset", this.addCards);
    this.listenTo(this.model.cards(), "remove", this.removeCard);
  },

  events: {
    "sortstop": "sort"
  },

  addCards: function () {
    this.model.cards().sort();
    this.removeSubviews(".cards-list");
    this.model.cards().each(this.addCard, this);
  },

  addCard: function (card) {
    var cardView = new TrelloClone.Views.CardShow({ model: card });
    this.addSubview(
      ".cards-list",
      cardView
      );
    var ord = this.subviews(".cards-list").value().length;
    card.set({ ord: ord });
    card.save();
    cardView.$el.attr("data-ord", ord);
  },

  render: function () {
    this.$el.html(this.template({ list: this.model }));
    this.addCards();
    this.$(".cards-list").sortable(
      {connectWith: ".cards-list"}
    );

    return this;
  },

  removeCard: function (card) {
    this.removeModelSubview(card);
  },


  sort: function (event, ui) {
    event.stopPropagation();
    var $card = ui.item;
    var card = this.model.cards().get($card.data("card-id"));
    //if this is a transfer, the card is now gone, so don't try to modify it.
    if (card) {
      TrelloClone.Sortable.setOrd($card, card);
    }
  },

});
