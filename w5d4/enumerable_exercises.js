Array.prototype.myEach = function (callback) {
  for (var i = 0; i < this.length; i++){
    callback(this[i]);
  }
};

// [1, 2, 3].myEach( function (el) {
//   // console.log(el);
// } );

Array.prototype.myMap = function (mapping) {
  var mapped = [];
  var func = function (el) {
    mapped.push(mapping(el));
  };
  this.myEach( func );

  return mapped;
};

// var mapped = [1, 2, 3].myMap( function (el) {
//     return el * 3;
// });
//
// // console.log(mapped);

Array.prototype.myInject = function (callback) {
  var accumulator = this[0];
  var func = function (el) {
    accumulator = callback(accumulator, el);
  };
  this.slice(1).myEach(func);
  return accumulator;
};

var test = [1,2,3].myInject(function(sum, num) {
  return sum + num;
});

console.log(test);
