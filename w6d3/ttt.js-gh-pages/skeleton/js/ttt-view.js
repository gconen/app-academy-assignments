(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.el = $el;
  };

  View.prototype.bindEvents = function () {
    var $cells = $(".cell");
    var that = this;
    $cells.on("click", function (event) {
      that.makeMove($(event.currentTarget));
    });
  };

  View.prototype.makeMove = function ($square) {
    $square.off("click");
    var pos = $square.attr("id").split(",");
    var player = this.game.currentPlayer;
    this.game.playMove([parseInt(pos[0]),parseInt(pos[1])]);
    if(player === "x"){
      $square.addClass("marked-x");
      $square.append("X");
    } else {
      $square.addClass("marked-o");
      $square.append("O");
    }
    if (this.game.isOver()) {
      if (this.game.winner()) {
        alert("Congratulations, " + this.game.winner());
      } else {
        alert("Tie");
      }
    }
  };

  View.prototype.setupBoard = function () {
    for(var i = 0; i < 3; i++){
      var newRow = $("<div>").addClass("row");
      this.el.append(newRow);
      for(var j=0; j<3; j++){
        var newCell = $("<div>").addClass("cell")
                                .attr("data-pos", [i,j]);
        newRow.append(newCell);
      }
    }
  };
})();
