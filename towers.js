var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function HanoiGame () {
  this.stacks = [[1, 2, 3],[],[]];
}

HanoiGame.prototype.isWon = function () {
  return this.stacks[1].length === 3 || this.stacks[2].length === 3;
};

HanoiGame.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
  if (startTowerIdx > 2 || endTowerIdx > 2) {
    return false;
  }
  if (this.stacks[startTowerIdx].length === 0) {
    return false;
  }
  if (this.stacks[startTowerIdx][0] > this.stacks[endTowerIdx][0]) {
    return false;
  }

  return true;
};

HanoiGame.prototype.move = function (startTowerIdx, endTowerIdx) {
  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].unshift(this.stacks[startTowerIdx].shift());
    return true;
  }

  return false;
};

HanoiGame.prototype.print = function () {
  console.log(this.stacks);
};

HanoiGame.prototype.promptMove = function (callback) {
  this.print();

  reader.question("Choose stack to move from: ", function (startTower) {
    reader.question("Choose stack to move to: ", function (endTower) {
      var start = parseInt(startTower);
      var end = parseInt(endTower);

      callback(start, end);
    });
  });
};

HanoiGame.prototype.run = function (completionCallback) {
  var that = this;
  this.promptMove(function (start, end) {
    var moved = that.move(start, end);
    if (!moved) {
      console.log("Illegal Move");
    }
    if (that.isWon()) {
      completionCallback();
    } else {
      that.run(completionCallback);
    }
  });
};

var game = new HanoiGame();
game.run( function(){
  console.log("You win!");
  reader.close();
});
