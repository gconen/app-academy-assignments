Pokedex.RootView.prototype.reassignToy = function (event) {
  console.log(event.currentTarget);
  var that = this;
  var oldPokemon = this.pokes.get($(event.currentTarget).data("pokemon-id"));
  var toy = oldPokemon.toys().get($(event.currentTarget).data("toy-id"));
  toy.set("pokemon_id", event.currentTarget.value);
  toy.save( {}, {
    success: function () {
      oldPokemon.toys().remove(toy);
      that.renderToysList(oldPokemon);
      that.$toyDetail.empty();
    }
  });
};

Pokedex.RootView.prototype.updateToy = function (event) {
  event.preventDefault();

  var $target = $(event.currentTarget);
  var pokemon = this.pokes.get($target.data("pokemon-id"));
  var toy = pokemon.toys().get($target.data("toy-id"));
  var formData = $target.serializeJSON();
  var that = this;
  toy.save(formData, {
    success: function () {
      that.renderToysList(pokemon);
      that.renderToyDetail(toy);
    },
    failure: function() { alert("fail!"); }
  });
};

Pokedex.RootView.prototype.renderToysList = function (pokemon) {
  var that = this;
  this.$el.find("ul.toys").empty();
  pokemon.fetch({
    success: function () {
      pokemon.toys().each(function (toy) {
        that.addToyToList(toy);
      });
    }
  });
};
