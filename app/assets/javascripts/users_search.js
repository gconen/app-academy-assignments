$.UsersSearch = function(el) {
  this.$searchDiv = $(el);
  this.$input = this.$searchDiv.children( 'input' );
  this.$ul = this.$searchDiv.children( 'ul' );
  this.$input.on( "keyup", this.handleInput.bind(this) );
};

$.UsersSearch.prototype.renderResults = function(users) {
  // debugger;

  this.$ul.empty();
  // debugger

  users.forEach( function(user) {
    var $li = $("<li>");
    $li.append( $("<a>").attr("href", "/users/" + user.id).append(user.username) );
    var $button = $("<button>");
    $li.append($button);
    $button.followToggle({
      userId: user.id,
      initialFollowState: (user.followed ? "followed" : "unfollowed")
    });
    this.$ul.append($li);
  }.bind(this));
};


$.UsersSearch.prototype.handleInput = function(event) {
  // debugger;

  var input = $(event.currentTarget).val();
  $.ajax({ url: "/users/search",
           method: "get",
           dataType: "json",
           data: {query: input},
           success: this.renderResults.bind(this)
        });
};

$.fn.usersSearch = function() {
  return this.each(function() {
    new $.UsersSearch(this);
  });
};


$(function() {
  $(".users-search").usersSearch();
});
