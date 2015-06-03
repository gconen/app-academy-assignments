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
    var listItem = template({ pokemon: pokemon });

    this.$el.append(listItem);
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      reset: true,
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
    var pokemonTemplate = JST["pokemonDetail"];

    this.$el.html(pokemonTemplate({ pokemon: this.model }));

    var toyTemplate = JST["toyListItem"];
    this.model.toys().each(function (toy) {
      this.$el.find(".toys").append(toyTemplate({ toy: toy }));
    }.bind(this));
  },

  selectToyFromList: function (event) {
    var $li = $(event.currentTarget);
    var toy = this.model.toys().get($li.data("id"));
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

  reassignToy: function (event) {
    var $select = $(event.currentTarget);
    var oldPokemon = this.collection.get($select.data("pokemon-id"));
    var toy = this.model;

    toy.set("pokemon_id", $select.val());
    toy.save({}, {
      success: function () {
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
