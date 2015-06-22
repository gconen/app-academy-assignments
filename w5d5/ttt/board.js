function Board() {
  this.grid = [ ['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_'] ];
}

Board.prototype.print = function () {
  console.log(this.grid[0]);
  console.log(this.grid[1]);
  console.log(this.grid[2]);
};

Board.prototype.isWinner = function (mark) {
  var g = this.grid;
  var posDiag = [ g[2][0], g[1][1], g[0][2] ];
  var negDiag = [ g[0][0], g[1][1], g[2][2] ];
  if (posDiag.myAll(mark) || negDiag.myAll(mark)) {
      return true;
  }

  for (var i = 0; i < 3; i++) {
    if (g[i].myAll(mark)) {
      return true;
    }

    if ([ g[0][i], g[1][i], g[2][i] ].myAll(mark)) {
      return true;
    }
  }

  return false;
};

Board.prototype.placeMark = function (coords, mark) {
  if (this.validMove(coords)){
    this.grid[coords[0]][coords[1]] = mark;
    return true;
  }

  return false;
};

Board.prototype.dup = function() {
  var dupedGrid = [];
  for (var i = 0; i < 3; i++) {
    dupedGrid.push(this.grid[i].slice());
  }
  var dupedBoard = new Board();
  dupedBoard.grid = dupedGrid;

  return dupedBoard;
};

Board.prototype.validMove = function(coords) {
  if (coords[0] > 2 || coords[0] < 0 || coords[1] > 2 || coords[1] < 0){
    return false;
  }
  if (this.grid[coords[0]][coords[1]] !== "_"){
    return false;
  }

  return true;
};

Board.prototype.isTie = function () {
  for (var i = 0; i < 3; i++){
    for (var j = 0; j < 3; j++){
      if (this.grid[i][j] === "_"){
        return false;
      }
    }
  }
  return true;
};

Array.prototype.myAll = function (thing) {
  for (var i = 0; i < this.length; i++) {
    if (this[i] !== thing) {
      return false;
    }
  }

  return true;
};

module.exports = Board;
