Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>").text("Toy: " + toy.escape("name") + ", Happiness: " + toy.escape("happiness") + ", Cost: $" + toy.escape("price"));
  $li.addClass('toy-list-item');
  $li.attr("data-toy-id", toy.escape("id")).attr("data-pokemon-id", toy.escape("pokemon_id"));
  $("ul.toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $detail = $("<div>").append($("<img src='" + toy.escape("image_url") +"'>"));
  $detail.addClass('detail');
  $detail.append($("<p>").append("Toy Name: " + toy.escape("name")));
  $detail.append($("<p>").append("Happiness Granted: " + toy.escape("happiness")));
  $detail.append($("<p>").append("Price: $" + toy.escape("price")));
  var pokemon = this.pokes.get(toy.get("pokemon_id"));

  var $label = $('<label>').text("Owning Pokemon: ");
  var $select = $('<select>').addClass('change-owner-select');
  $select.attr('data-toy-id', toy.get('id')).attr('data-pokemon-id', pokemon.get("id"));
  $label.append($select);

  for (var i = 0; i < this.pokes.length; i++) {
    var curPoke = this.pokes.at(i);
    var $option = $('<option>').attr('value', curPoke.get('id'));

    $option.text(curPoke.get('name'));
    if (pokemon.get('id') === curPoke.get('id')) {
      $option.prop('selected', true);
    }
    $select.append($option);
  }
  $detail.append($label);
  // $detail.append($("<p>").append("Owning Pokemon: " + pokemon.escape("name")));
  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokemon = this.pokes.get($(event.currentTarget).data("pokemon-id"));
  var toy = pokemon.toys().get($(event.currentTarget).data("toy-id"));
  this.renderToyDetail(toy);
};
