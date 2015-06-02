Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:pokemon_id/toys/:toy_id(/)": "toyDetail",
    "pokemon/:id(/)": "pokemonDetail"
  },

  pokemonDetail: function (id, callback) {
    this._pokemonDetail && this._pokemonDetail.remove();
    this._toyDetail && this._toyDetail.remove();
    if (!this._pokemonIndex) {
      this.pokemonIndex(function () {
        this.pokemonDetail(id, callback);
      }.bind(this));
    }
    else {
      this._pokemonDetail && this._pokemonDetail.remove();
      this._toyDetail && this._toyDetail.remove();
      var pokemon = this._pokemonIndex.collection.get(id);
      this._pokemonDetail = new Pokedex.Views.PokemonDetail({model: pokemon});
      $("#pokedex .pokemon-detail").html(this._pokemonDetail.$el);
      this._pokemonDetail.refreshPokemon( {
        success: function () {
          callback && callback();
        }
      });
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonDetail && this._pokemonDetail.remove();
    this._toyDetail && this._toyDetail.remove();
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this.pokemonForm();
    this._pokemonIndex.refreshPokemon( {
      success: function () {
        callback && callback();
      }
    });
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
    this._toyDetail && this._toyDetail.remove();
    if(!this._pokemonDetail){
      this.pokemonDetail(pokemonId, function () {
        this.toyDetail(pokemonId, toyId);
      }.bind(this));
    } else {
      this._toyDetail && this._toyDetail.remove();
      var toy = this._pokemonDetail.model.toys().get(toyId);
      this._toyDetail = new Pokedex.Views.ToyDetail(
        { model: toy, collection: this._pokemonIndex.collection }
      );
      $("#pokedex .toy-detail").html(this._toyDetail.$el);
      this._toyDetail.render();
    }
  },

  pokemonForm: function () {
    this._form = new Pokedex.Views.PokemonForm(
      { model: new Pokedex.Models.Pokemon(),
        collection: this._pokemonIndex.collection
      });
    $("#pokedex .pokemon-form").html(this._form.$el);
    this._form.render();
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
  debugger;
});
