Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detail = $("<div>").addClass("detail");
  $detail.append($("<img src='" + pokemon.escape("image_url") +"'>"));
  $detail.append($("<p>").text("Name: " + pokemon.get("name")));
  $detail.append($("<p>").text("Type: " + pokemon.get("poke_type").toUpperCase()));
  $detail.append($("<p>").text("Moves: " + pokemon.get("moves")));
  $detail.append($("<p>").text("Attack: " + pokemon.get("attack")));
  $detail.append($("<p>").text("Defense: " + pokemon.get("defense")));
  $detail.append($("<ul>").addClass("toys"));
  this.renderToysList(pokemon);
  this.$pokeDetail.html($detail);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var id = event.currentTarget.id;
  var clickedPoke = this.pokes.get(id);
  this.renderPokemonDetail(clickedPoke);
};
