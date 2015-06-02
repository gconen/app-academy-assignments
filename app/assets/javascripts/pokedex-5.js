Pokedex.Views = {};

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "sync add", this.render);
  },

  addPokemonToList: function (pokemon) {
    var template = JST["pokemonListItem"];
    var list = template({ pokemon: pokemon });

    this.$el.append(list);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: function() {
        if (options) {
          options.success && options.success();
        }
      }.bind(this)
    });

    return this;
  },

  render: function () {
    this.$el.empty();
    this.collection.each(function (pokemon) {
      this.addPokemonToList(pokemon);
    }.bind(this));

    return this;
  },

  selectPokemonFromList: function (event) {
    var $li = $(event.currentTarget);
    var id = $li.data("id");
    var pokemon = this.collection.get(id);
    Backbone.history.navigate("/pokemon/" + pokemon.id, { trigger: true });
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: function() {
        this.render();
        if (options) {
          options.success && options.success();
        }
      }.bind(this)
    });
  },

  render: function () {
    var template = JST["pokemonDetail"];

    this.$el.html(template({ pokemon: this.model }));

    this.model.toys().each(function (toy) {
      var template = JST["toyListItem"];
      this.$el.find(".toys").append(template({ toy: toy }));
    }.bind(this));
  },

  selectToyFromList: function (event) {
    var li = $(event.currentTarget);
    var toy = this.model.toys().get(li.data("id"));
    Backbone.history.navigate(
      "pokemon/" + toy.get("pokemon_id") + "/toys/" + toy.get("id"),
      { trigger: true }
    );
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  events: {
    "change select": "reassignToy"
  },

  reassignToy: function(event) {
    var option = $(event.currentTarget);
    var oldPokemon = this.collection.get(option.data("pokemon-id"));
    var toy = this.model;

    toy.set("pokemon_id", option.val());
    toy.save({}, {
      success: function() {
        oldPokemon.toys().remove(toy);
        Backbone.history.navigate("pokemon/" + oldPokemon.id, { trigger: true});
      }
    });
  },

  render: function () {
    var template = JST["toyDetail"];
    this.$el.html(template({ toy: this.model, pokes: this.collection }));
  }
});

// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
