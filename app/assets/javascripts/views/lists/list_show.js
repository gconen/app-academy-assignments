TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  tagName: "li",
  className: "list",
  attributes: function () {
    return { "data-list-id": this.model.get("id") };
  },

  template: JST['lists/show'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.cards(), "add", this.addCard);
    this.listenTo(this.model.cards(), "reset", this.addCards);
    this.addCards();
  },

  events: {
    "sortstop": "sort"
  },

  addCards: function() {
    this.model.cards().each(this.addCard, this);
  },

  addCard: function(card) {
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
    this.attachSubviews();

    return this;
  },

  sort: function (event, ui) {
    var $card = ui.item;
    var card = this.model.cards().get($card.data("card-id"));
    this.setOrd($card, card);
  },


});

$.extend(TrelloClone.Views.ListShow.prototype, TrelloClone.Sortable.prototype);
