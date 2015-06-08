TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({

  template: JST['boards/show'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.addList);
    this.listenTo(this.model.lists(), "reset", this.addLists);
  },

  events: {
    "sortstop": "sort"
  },

  addLists: function() {
    this.model.lists().each(this.addList, this);
  },

  addList: function(list) {
    var listView = new TrelloClone.Views.ListShow({ model: list });
    this.addSubview(
      "#board-lists-list",
      listView
    );
    var ord = this.subviews("#board-lists-list").value().length;
    list.set({ ord: ord });
    list.save();
    listView.$el.attr("data-ord", ord);
  },

  render: function () {
    this.$el.html(this.template(
      { board: this.model }
    ));
    this.attachSubviews();
    this.$("#board-lists-list").sortable();

    return this;
  },

  sort: function (event, ui) {
    event.stopPropagation();
    var $list = ui.item;
    var list = this.model.lists().get($list.data("list-id"));
    TrelloClone.Sortable.setOrd($list, list);
  },

});
