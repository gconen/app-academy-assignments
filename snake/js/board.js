(function(){
  if (typeof Snake === "undefined"){
      window.Snake = {};
  }

  var Board = Snake.Board = function () {
    this.snake = new Snake.Snake();
    this.apple = [Math.floor(Math.random() * 100),Math.floor(Math.random() * 40)];
  };

  Board.prototype.move = function () {
    this.snake.move();
    var segments = this.snake.segments;
    if (Snake.arrayEq(this.apple, segments[0])) {
      this.apple = [Math.floor(Math.random() * 100),Math.floor(Math.random() * 40)];
      var lastCoord = segments[segments.length - 1].slice();
      segments.push(lastCoord);
      this.snake.score += 10;
    }
  };

  Snake.arrayEq = function arrayEq(arr1, arr2) {
    if (arr1.length !== arr2.length) {
      return false;
    }
    for (var i = 0; i < arr1.length; i ++) {
      if (arr1[i] !== arr2[i]) {
        return false;
      }
    }

    return true;
  };

  Board.prototype.render = function () {
    var result = [];
    for (var i = 0; i < 40; i++) {
      result[i] = [];
      for (var j = 0; j < 100; j++) {
        result[i].push('.');
      }
    }
    for (i = 0; i < this.snake.segments.length; i++) {
      var x = this.snake.segments[i][0];
      var y = this.snake.segments[i][1];
      result[y][x] = 'S';
    }

    for(i = 0; i < 40; i++){
      result[i] = result[i].join("");
    }

    var string = result.join("\n");

    return string;
  };


})();
