Pokedex.RootView.prototype.addToyToList = function (toy) {
  var template = JST["toyListItem"];
  this.$pokeDetail.find(".toys").append(template({ toy: toy }));
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) { // III
  this.$toyDetail.empty();

  var template = JST["toyDetail"];
  var html = template({ toy: toy, pokes: this.pokes });

  this.$toyDetail.html(html);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var $target = $(event.target);
  var toyId = $target.data('id');
  var pokemonId = $target.data('pokemon-id');

  var pokemon = this.pokes.get(pokemonId);
  var toy = pokemon.toys().get(toyId);

  this.renderToyDetail(toy);
};
