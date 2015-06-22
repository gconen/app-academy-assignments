(function () {
  if (typeof Snake === "undefined") {
    window.Snake = {};
  }

  var View = Snake.View = function(board, $el){
    this.board = board;
    this.$el = $el;
    this.bindEvents();
    this.setup();
    this.myInterval = window.setInterval(this.step.bind(this), 200);
  };

  View.prototype.bindEvents = function(){
    var that = this;
    $(window).on("keydown", function(event) {
      console.log("keydown");
      switch(event.which){
        case 37:
          that.board.snake.turn("W");
          break;
        case 38:
          that.board.snake.turn("N");
          break;
        case 39:
          that.board.snake.turn("E");
          break;
        case 40:
          that.board.snake.turn("S");
          break;
        case 80:
          that.pause();
          break;
        case 32:
          that.restart();
          break;
      }
    });
  };

  View.prototype.step = function () {
    this.board.move();

    this.render();
  };

  View.prototype.pause = function(){
    clearInterval(this.myInterval);
  };

  View.prototype.restart = function(){
    this.myInterval = window.setInterval(this.step.bind(this), 200);
  };

  View.prototype.render = function () {
    $(".segment").removeClass("snake");
    $(".segment").removeClass("head");
    $(".segment").removeClass("apple");
    $(".score").empty().append(this.board.snake.score);

    var segments = this.board.snake.segments;
    for(var i = 0; i < segments.length; i++){
      var x = segments[i][0];
      var y = segments[i][1];
        $("#" + x + "-" + y).addClass("snake");


    }
    var apple = this.board.apple;
      $("#" + apple[0] + "-" + apple[1]).addClass("apple");


  };


  View.prototype.setup = function(){
    for(var i =0; i < 40; i++ ){
      var newRow = $("<div>").addClass("row");
      this.$el.append(newRow);
      for(var j = 0; j < 100; j++){
        var newCell = $('<div>').addClass("segment").attr("id",j + "-" + i);
        newRow.append(newCell);
      }
    }
  };


})();
