$.TweetCompose = function(form) {
  this.$form = $(form);
  this.$form.on("submit", this.submit.bind(this));
  this.$userText = this.$form.find("textarea");
  this.$userText.on("keyup", this.charsLeft.bind(this));
  this.$mentionedUsers = this.$form.find(".mentioned-users");
  this.$mentionedUsers.find(".add-mentioned-user")
                      .on("click", this.addMentionedUser.bind(this));
  this.$form.on("click",
                "a.remove-mentioned-user",
                this.removeMentionedUser.bind(this)
                );
};

$.TweetCompose.prototype.removeMentionedUser = function(event) {
  $(event.currentTarget).parent().remove();
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();

  var formData = $(event.currentTarget).serialize();
  $.ajax({
    url: "/tweets",
    method: "POST",
    dataType: "json",
    data: formData,
    success: this.handleSuccess.bind(this)
  });
  this.$form.find(":input").prop("disabled", true);
};

$.TweetCompose.prototype.handleSuccess = function(response) {
  this.$form.find(":input").prop("disabled", false);
  var $ul = $( this.$form.data("tweets-ul-id") );
  $ul.prepend( $("<li>").text( JSON.stringify(response) ));
  this.$userText.val("");
  this.$mentionedUsers.find(".mentions").empty();
};

$.TweetCompose.prototype.charsLeft = function(event) {
  var text = $(event.currentTarget).val();
  var remaining = 140 - text.length;
  if (remaining < 0) {
    $(event.currentTarget).val( text.slice(0, 140) );
  }
  this.$form.find(".chars-left").text(remaining + " chars left");
};

$.TweetCompose.prototype.addMentionedUser = function(event) {
  var $scriptContent = this.$form.find("script").html();
  this.$mentionedUsers.find(".mentions").append($scriptContent);
};

$.fn.tweetCompose = function () {
  return this.each( function () {
    new $.TweetCompose(this);
  });
};

$(function () {
  $('.tweet-compose').tweetCompose();
});
