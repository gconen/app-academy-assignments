TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
      "(/)": "index",
      "(/)boards/:id(/)": "show"
  },

  initialize: function (options) {
    this.boards = options.boards;
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    var view = new TrelloClone.Views.BoardsIndex({ collection: this.boards});
    this._swapView(view);
  },

  show: function (id) {
    var view = new TrelloClone.Views.BoardShow({
      model: this.boards.getOrFetch(id)
    });
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(this._currentView.render().$el);
  }

});
