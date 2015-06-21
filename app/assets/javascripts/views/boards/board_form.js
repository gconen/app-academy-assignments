TrelloClone.Views.BoardForm = Backbone.View.extend({
  tagName: "form",
  className: "boards-form",

  template: JST['boards/form'],

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "click button": "createBoard"
  },

  createBoard: function (event) {
    event.preventDefault();

    var formData = this.$el.serializeJSON();

    this.model.save(
      formData,
      {
        success: this.collection.add.bind(this.collection, this.model)
      }
    );
  },


  render: function () {
    this.$el.html(this.template({ board: this.model }));

    return this;
  }



});
