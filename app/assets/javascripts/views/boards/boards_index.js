TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({

  template: JST['boards/index'],

  initialize: function (options) {
    this.listenTo(this.collection, "reset", this.addBoards);
    this.listenTo(this.collection, "add", this.addBoard);
    this.addSubview(
      "#new-board-container",
      new TrelloClone.Views.BoardForm ({
        model: new TrelloClone.Models.Board(),
        collection: this.collection
      })
    );
    this.addBoards();
  },


  addBoards: function() {
    this.collection.each(this.addBoard, this);
  },

  addBoard: function(board) {
    this.addSubview(
      "#boards-index-list",
      new TrelloClone.Views.BoardsIndexItem({ model: board })
      );
  },


  render: function () {
    this.$el.html(this.template());
    this.attachSubviews();

    return this;
  }



});
