Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $detail = $("<div>").addClass("detail");
  $detail.append($("<img src='" + pokemon.escape("image_url") +"'>"));

  var $nameLabel = $("<label>").append("Name:");
  var $nameInput = $("<input>").attr("type", "text").
                              attr("name", "pokemon[name]").
                              attr("value", pokemon.escape("name"));
  $nameLabel.append($nameInput);
  $form.append($nameLabel);


  var $typeLabel = $("<label>").append("Name:");
  var $typeInput = $("<input>").attr("type", "text").
                              attr("name", "pokemon[poke_type]").
                              attr("value", pokemon.escape("poke_type"));
  $typeLabel.append($typeInput);
  $form.append($typeLabel);

  var $moveLabel = $("<label>").append("Moves:");
  for (var i = 0; i < 4; i++) {
    var $typeInput = $("<input>").attr("type", "text").
                                attr("name", "pokemon[moves][]")

      .attr("value", pokemon.escape("moves"));
    $moveLabel.append($typeInput);
  }
  $form.append($moveLabel);

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
