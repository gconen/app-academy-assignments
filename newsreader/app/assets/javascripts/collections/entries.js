NewsReader.Collections.Entries = Backbone.Collection.extend({

  model: NewsReader.Models.Entry,

  initialize: function (options) {
    this.feed = options.feed;
  },

  url: function() {
    return "/api/" + this.feed.id + "/entries";
  }
});
