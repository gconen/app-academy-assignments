TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({

  template: JST['boards/show'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.addList);
    this.listenTo(this.model.lists(), "reset", this.addLists);
  },

  addLists: function() {
    this.model.lists().each(this.addList, this);
  },

  addList: function(list) {
    this.addSubview(
      "#board-lists-list",
      new TrelloClone.Views.ListShow({ model: list })
      );
  },


  render: function () {
    this.$el.html(this.template(
      { board: this.model }
    ));
    this.attachSubviews();
    this.$("ul").sortable();

    return this;
  }



});
