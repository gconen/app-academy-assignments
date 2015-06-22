


Array.prototype.uniq = function () {
  var alreadySeen = [];
  for ( var i = 0; i < this.length; i++ ) {
    if ( alreadySeen.indexOf(this[i]) === -1 ) {
      alreadySeen.push(this[i]);
    }
  }

  return alreadySeen;
};

// console.log([1, 2, 1, 3, 3].uniq());

Array.prototype.twoSum = function () {
  var pairs = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0){
        pairs.push([i, j]);
      }
    }
  }
  return pairs;
};

// console.log([-1, 0, 2, -2, 1].twoSum());


Array.prototype.myTranspose = function () {
  var transpose = [];
  for (var i = 0; i < this.length; i++) {
    var row = [];
    for (var j = 0; j < this.length; j++) {
      row.push(this[j][i]);
    }
    transpose.push(row);
  }
  return transpose;
};

console.log([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].myTranspose());
