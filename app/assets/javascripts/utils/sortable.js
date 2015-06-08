TrelloClone.Sortable = function () {};
TrelloClone.Sortable.prototype.setOrd = function ($el, model) {
  var $prev = $el.prev();
  var $next = $el.next();
  var prevOrd = ( $prev.length > 0 ? $prev.data("ord") : 0 );
  var nextOrd = ( $next.length > 0 ? $next.data("ord") : prevOrd + 2 );
  var ord = prevOrd + ((nextOrd - prevOrd) / 2.0);
  model.set({ord: ord});
  model.save();
  $el.attr("data-ord", ord);
};
