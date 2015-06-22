var Board = require('./board.js');

function Game(xPlayer,oPlayer) {
  this.turn = "O";
  this.board = new Board();
  this.xPlayer = xPlayer;
  this.oPlayer = oPlayer;
  this.xPlayer.mark = "X";
  this.oPlayer.mark = "O";
}

Game.prototype.gameOver = function () {
  if (this.board.isTie()) {
    return "Tie";
  } else if (this.board.isWinner("O")){
    return "O";
  } else if (this.board.isWinner("X")){
    return "X";
  } else {
    return false;
  }
};

Game.prototype.run = function (completionCallback){
  var result = this.gameOver();
  this.board.print();
  if (result) {
    completionCallback(result);
  } else {
    var that = this;
    this.promptMove(function (move) {
      var moved = that.board.placeMark(move, that.turn);
      if (moved) {
        that.turn = ( that.turn === 'X' ? 'O' : 'X');
      } else {
        console.log ("Illegal Move.");
      }
      that.run(completionCallback);
    });
  }
};

Game.prototype.promptMove = function(callback) {
  console.log("It's " + this.turn + "'s turn");
  var fn = function (input) {
    var move = input.split(',').map( function(el) {
      return parseInt(el);
    });
    console.log(move);
    callback(move);
  };
  if (this.turn === 'O') {
    this.oPlayer.question(this.board, fn);
  } else {
    this.xPlayer.question(this.board, fn);
  }
};


module.exports = Game;
