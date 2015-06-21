JournalApp.Views.PostsIndex = Backbone.View.extend({

  template: JST['posts/index'],

  initialize: function() {
    this.listenTo(this.collection, "reset add remove change", this.render);
  },

  render: function () {
    var that = this;
    this.$el.html(this.template());
    this.collection.each( function (model) {
      var subView = new JournalApp.Views.PostsIndexItem({ model: model });
      subView.render().$el.appendTo(that.$el.find("ul"));
    });
    return this;
  }

});
