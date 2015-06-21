NewsReader.Models.Entry = Backbone.Model.extend({
  urlRoot: function() {
    return "/api/" + this.feed.id + "/entries";
  }
});
