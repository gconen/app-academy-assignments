Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var poke = new Pokedex.Models.Pokemon(attrs);
  var that = this;

  poke.save({}, {success: function (){
    that.pokes.add(poke);
    that.addPokemonToList(poke); 
    if (callback) {
      callback(poke);
    }
  }});
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var that = this;
  var formData = $(event.currentTarget).serializeJSON();
  that.createPokemon(formData, that.renderPokemonDetail.bind(that));
};
