(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.el = $el;
    this.setupTowers();
    this.render();
    this.bindEvents();
  };

  View.prototype.bindEvents = function(){
    $(".tower").on("click", this.clickTower.bind(this));
  };

  View.prototype.clickTower = function (event) {
    var tower = event.currentTarget;
    if (this.clickedTowerNum) {
      var moved = this.game.move(this.clickedTowerNum, tower.id);
      if (!moved) {
        alert("Illegal Move");
      }
      this.clickedTowerNum = null;
      this.render();
      if (this.game.isWon()){
        alert("You Win!");
      }
    } else {
      this.clickedTowerNum = tower.id;
    }
  };

  View.prototype.move = function(){

  };

  View.prototype.setupTowers = function(){
    for(var i = 0; i< 3; i++){
      var newTower = $("<div>").addClass("tower").attr("id", i);
      this.el.append(newTower);
      newTower.append($("<div>").addClass("disc").addClass("disc-large"));
      newTower.append($("<div>").addClass("disc").addClass("disc-medium"));
      newTower.append($("<div>").addClass("disc").addClass("disc-small"));
    }
  };

  View.prototype.render = function(){
    $(".disc").removeClass("shown");
    var towers = this.game.towers;
    var $viewTowers = $('.tower');
    for (var i = 0; i < 3; i++){
      for (var j = 0; j < towers[i].length; j++) {
        if (towers[i][j] === 3) {
          $viewTowers.eq(i).find(".disc-large").addClass("shown");
        }
        if (towers[i][j] === 2) {
          $viewTowers.eq(i).find(".disc-medium").addClass("shown");
        }
        if (towers[i][j] === 1) {
          $viewTowers.eq(i).find(".disc-small").addClass("shown");
        }
      }
    }
  };

})();
