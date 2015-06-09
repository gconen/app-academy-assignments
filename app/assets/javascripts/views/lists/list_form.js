TrelloClone.Views.ListForm = Backbone.View.extend({
  template: JST["lists/form"],
  tagName: "form",
  className: "list-form",

  events: {
    "submit": "addList"
  },


  addList: function (event) {
    event.preventDefault();
    this.model.set(
      { title: this.$("#list-title").val() }
    );
    this.model.save({}, {
      success: this.listAdded.bind(this)
    });
  },

  listAdded: function (){
    this.collection.add(this.model);
    var boardId = this.model.get("board_id");
    this.model = new TrelloClone.Models.List ( {board_id: boardId });
  },

  render: function () {
    this.$el.html(this.template());
    return this;
  }


});
