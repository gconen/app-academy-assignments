$.FollowToggle = function (el, options) {
  options = options || {};
  this.$button = $(el);
  this.userId = options.userId || this.$button.data("user-id");
  if (options.initialFollowState) {
    this.followState = options.initialFollowState;
  } else if (this.$button.data("initial-follow-state") === true) {
    this.followState = "followed";
  } else {
    this.followState = "unfollowed";
  }
  this.render();
  this.$button.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {
  if (this.followState === "unfollowed") {
    this.$button.html("Follow");
    this.$button.prop("disabled", false);
  } else if (this.followState === "followed") {
    this.$button.html("Stop Following");
    this.$button.prop("disabled", false);
  } else {
    this.$button.html("Please Wait");
    this.$button.prop("disabled", true);
  }
};

$.FollowToggle.prototype.handleClick = function (event) {
  event.preventDefault();
  if (this.followState === "unfollowed") {
    $.ajax({url: '/users/' + this.userId + '/follow',
            method: 'POST',
            success: this.toggleState.bind(this),
            dataType: "json"
            });
    this.followState = "following";
  } else if (this.followState === "followed") {
    $.ajax({url: '/users/' + this.userId + '/follow',
            method: 'DELETE',
            success: this.toggleState.bind(this),
            dataType: "json"
            });
    this.followState = "unfollowing";
  }
  this.render();
};

$.FollowToggle.prototype.toggleState = function(response) {
  if (this.followState === "following") {
    this.followState = "followed";
  } else {
    this.followState = "unfollowed";
  }
  this.render();
};

$.fn.followToggle = function (options) {
  return this.each(function () {
    new $.FollowToggle(this, options);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
