Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit .new-pokemon": "savePokemon"
  },

  render: function () {
    var template = JST["pokemonForm"];
    this.$el.html(template());
  },

  savePokemon: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    console.log(formData["pokemon"]);
    this.model.save(formData["pokemon"], {
      success: function () {
        this.collection.add(this.model);
        Backbone.history.navigate(
          "pokemon/" + this.model.get("id"),
          { trigger: true }
        );
      }.bind(this)
    });
  }
});
