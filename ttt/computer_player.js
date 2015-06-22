

function ComputerPlayer(){
}

ComputerPlayer.prototype.question = function(board, callback) {
  var move = this.calculateMove(board);
  if (move) {
    callback(move[0] + "," + move[1]);
  } else {
    var x = Math.floor(Math.random()*3);
    var y = Math.floor(Math.random()*3);
    while (!board.validMove([x,y])) {
      x = Math.floor(Math.random()*3);
      y = Math.floor(Math.random()*3);
    }
    callback(x + "," + y);
  }
};

ComputerPlayer.prototype.calculateMove = function(board) {
  var dupedBoard, i, j;

  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      dupedBoard = board.dup();
      dupedBoard.placeMark([i,j], this.mark);
      if (dupedBoard.isWinner(this.mark)) {
        return [i,j];
      }
    }
  }
  var otherMark = ( this.mark === "O" ? "X" : "O");
  for (i = 0; i < 3; i++) {
    for (j = 0; j < 3; j++) {
      dupedBoard = board.dup();
      dupedBoard.placeMark([i,j], otherMark);
      if (dupedBoard.isWinner(otherMark)) {
        return [i,j];
      }
    }
  }
};

module.exports = ComputerPlayer;
