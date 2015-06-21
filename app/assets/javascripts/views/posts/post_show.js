JournalApp.Views.PostShow = Backbone.View.extend({

  template: JST['posts/show'],

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model, "remove", Backbone.history.navigate.bind(Backbone.history, ""));
  },

  events: {
    "click .post-delete-button": "deletePost",
    "dblclick .fancyable": "makeEditBox",
    "blur .fancy-form": "saveEditBox"
  },

  makeEditBox: function(event) {
    var $target = $(event.currentTarget);
    var val = $target.text();
    var $form = $('<textarea>').text(val).addClass('fancy-form');
    $target.html($form);
  },

  saveEditBox: function(event) {
    var $target = $(event.currentTarget);
    var val = $target.val();
    var $parent = $target.parent();
    $parent.text(val);

    var name = $parent.attr("name");
    var postParams = {};
    postParams[name] = val;
    this.model.save(
      { post: postParams },
      { success: function () {
          console.log("success");
        }
      }
    );
  },

  deletePost: function () {
    this.model.destroy({
      success: function(){
        this.remove();
        Backbone.history.navigate('', {trigger: true});
      }.bind(this),
    });
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));

    return this;
  }

});
