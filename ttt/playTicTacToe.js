var index = require('./index');
var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var player1 = new index.HumanPlayer(reader);
var player2 = new index.ComputerPlayer();

var game = new index.Game(player1, player2);
game.run( function (result) {
  console.log(result);
  reader.close();
});
