(function(){

  if (typeof Snake === "undefined"){
    window.Snake = {};
  }

  var starting = [[50,28],[50,29],[50,30]];

  Snake.Snake = function(){
    this.dir="N";
    this.segments=[[50,28],[50,29],[50,30]];
    this.score = 0;
  };

  Snake.Snake.prototype.move = function(){
    var prev = [this.segments[0][0],this.segments[0][1]];
    var head = this.segments[0];
    switch(this.dir) {
      case "N":
        head[1] += -1;
        break;
      case "S":
        head[1] += 1;
        break;
      case "W":
        head[0] += -1;
        break;
      case "E":
        head[0] += 1;
        break;
    }


    for(var i = 1; i<this.segments.length; i++){
      var tempPrev = [this.segments[i][0],this.segments[i][1]];
      this.segments[i][0] = prev[0];
      this.segments[i][1] = prev[1];

      prev = tempPrev;
      if (Snake.arrayEq(this.segments[0], this.segments[i])) {
        console.log("You Lose!");
        this.segments = [[50,28],[50,29],[50,30]];
        this.dir="N";
        this.score = 0;
      }
    }

    if (head[0] < 0 || head[0] > 99 || head[1] < 0 || head[1] > 39) {
      console.log("You Lose!");
      this.segments = [[50,28],[50,29],[50,30]];
      this.dir="N";
      this.score = 0;
    }


  };

  Snake.Snake.prototype.turn = function (direction) {
    this.dir = direction;
  };



})();
