Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var template = JST["pokemonListItem"];
  var list = template({ pokemon: pokemon });

  this.$el.append(list);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch({
    success: (function () {
      this.$pokeList.empty();
      this.pokes.each(this.addPokemonToList.bind(this));
    }).bind(this)
  });

  return this.pokes;
};
