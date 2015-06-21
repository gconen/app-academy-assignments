TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: "api/boards",
  model: TrelloClone.Models.Board,

  getOrFetch: function (id) {
    var model = this.get(id);
    if (model) {
      model.fetch();
    } else {
      model = new this.model({ id: id });
      model.fetch ({
        success: this.add.bind(this, model)
      });
    }

    return model;
  }

});
