var Game = require('./game');

function HumanPlayer(reader) {
  this.reader = reader;
}

HumanPlayer.prototype.question = function (board, callback) {
  this.reader.question("Enter a Move (e.g. 0,0): ", callback);
};


module.exports = HumanPlayer;
