JournalApp.Views.PostsIndexItem = Backbone.View.extend({

  template: JST['posts/index_item'],
  tagName: "li",

  events: {
    "click .post-delete-button": "deletePost"
  },

  deletePost: function () {
    this.model.destroy({
      success: this.remove.bind(this)
    });
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));

    return this;
  }

});
