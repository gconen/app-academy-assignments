var Cat = function (name, owner) {
  this.name = name;
  this.owner = owner;
};
Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name + ".";
};
var gizmo = new Cat("gizmo", "ned");
var markov = new Cat("markov", "ned");
console.log(gizmo.cuteStatement());
console.log(markov.cuteStatement());
Cat.prototype.cuteStatement = function () {
  return "Everyone loves " + this.name + ".";
};
console.log(gizmo.cuteStatement());
console.log(markov.cuteStatement());
Cat.prototype.meow = function () {
  console.log("meow");
};
gizmo.meow();
markov.meow();
gizmo.meow = function () {
  console.log("MEOW!!!!!!!!!!!!!!");
};
gizmo.meow();
markov.meow();
