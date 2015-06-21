JournalApp.Views.PostForm = Backbone.View.extend({

  template: JST['posts/form'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit .post-form": "submitForm"
  },

  submitForm: function (event) {
    event.preventDefault();
    var $target = $(event.currentTarget);
    var formData = $target.serializeJSON();
    this.model.save(formData, {
      success: function () {
        Backbone.history.navigate(
        'posts/' + this.model.get('id'),
        {trigger: true}
        );
      }.bind(this),
      wait: true 
    });
  },


  render: function () {
    this.$el.html(this.template({ post: this.model }));

    return this;
  }

});
