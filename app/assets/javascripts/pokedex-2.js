Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>").text(
    "Toy: " + toy.escape("name") +
    ", Happiness: " + toy.escape("happiness") +
    ", Cost: $" + toy.escape("price"));
  $li.addClass('toy-list-item');
  $li.
    attr("data-toy-id", toy.escape("id")).
    attr("data-pokemon-id", toy.escape("pokemon_id"));
  $("ul.toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $detail = $("<div>").addClass('detail');
  $detail.append($("<img>").attr('src', toy.escape("image_url")));
  var $form = $("<form>").addClass("edit-toy-form");
  $form.attr('data-toy-id', toy.get('id'));
  $form.attr('data-pokemon-id', toy.get('pokemon_id'));

  var $nameLabel = $("<label>").append("Toy Name:");
  var $nameInput = $("<input>").attr("type", "text").
                              attr("name", "toy[name]").
                              attr("value", toy.escape("name"));
  $nameLabel.append($nameInput);
  $form.append($nameLabel);

  var $happinessLabel = $("<label>").append("Happiness Granted:");
  var $happinessInput = $("<input>").attr("type", "text").
                              attr("name", "toy[happiness]").
                              attr("value", toy.escape("happiness"));
  $happinessLabel.append($happinessInput);
  $form.append($happinessLabel);

  var $priceLabel = $("<label>").append("Price:");
  var $priceInput = $("<input>").attr("type", "text").
                              attr("name", "toy[price]").
                              attr("value", toy.escape("price"));
  $priceLabel.append($priceInput);
  $form.append($priceLabel);

  var pokemon = this.pokes.get(toy.get("pokemon_id"));

  var $label = $('<label>').text("Owning Pokemon: ");
  var $select = $('<select>').attr("name", "toy[pokemon_id]");
  $label.append($select);

  // TA: use .each
  var that = this;
  this.pokes.each (function (curPoke) {
    var $option = $('<option>').attr('value', curPoke.id);
    $option.text(curPoke.get('name'));
    if (pokemon.id === curPoke.id) {
      $option.prop('selected', true);
    }
    $select.append($option);
  });

  $form.append($label);

  $form.append($("<input>").attr("type", "submit").attr("value", "Edit Toy"));

  $detail.append($form);
  this.$toyDetail.html($detail);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  var pokemon = this.pokes.get($(event.currentTarget).data("pokemon-id"));
  var toy = pokemon.toys().get($(event.currentTarget).data("toy-id"));
  this.renderToyDetail(toy);
};
