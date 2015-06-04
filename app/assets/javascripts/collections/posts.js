JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "/posts",

  model: JournalApp.Models.Post,
  
  getOrFetch: function (id) {
    var that = this;
    var model = this.get(id);
    if (!model) {
      model = new JournalApp.Models.Post({ id: id });
      model.fetch({
        success: that.add.bind(that, model)
      });
    } else {
      model.fetch();
    }
    return model;
  }
});
