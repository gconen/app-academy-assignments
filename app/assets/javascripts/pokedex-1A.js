Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $listItem = $('<li>').text(pokemon.escape('name') + ', Type: ' + pokemon.escape('poke_type').toUpperCase());
  $listItem.addClass('poke-list-item').attr("id", pokemon.get("id"));
  this.$pokeList.append($listItem);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var that = this;
  that.pokes.fetch({
    success: function (pokemon){
      for (var i = 0; i < pokemon.length; i++) {
        that.addPokemonToList(pokemon.at(i));
      }
    }
  });
};
