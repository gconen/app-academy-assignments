TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
      "(/)": "index"
  },

  initialize: function (options) {
    this.boards = options.boards;
    this.$rootEl = options.$rootEl;
  },

  index: function () {
    var view = new TrelloClone.Views.BoardsIndex({ collection: this.boards});
    this._swapView(view);
  },

  _swapView: function (view) {
    this._currentView && this.currentView.remove();
    this._currentView = view;
    this.$rootEl.html(this._currentView.render().$el);
  }

});
