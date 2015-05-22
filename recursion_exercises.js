var exp = function ( base, power ) {
  if (power === 0) {
    return 1;
  }
  return base * exp( base, power -1 );
};

var exp2 = function( base, power ) {
  var root;
  if (power === 0) {
    return 1;
  }
  if ( power === 1) {
    return base;
  }
  if ( power % 2 === 0) {
    root = exp2(base, power/2);
    return root * root;
  } else {
    root = exp2(base, (power-1) / 2 );
    return base * root * root;
  }
};


var fib = function (count) {
  if (count === 1) {
    return [0];
  }
  var fibs = [0,1];
  for (var i = 2; i < count; i++) {
    var lastTwo = fibs.slice(-2);
    fibs.push(lastTwo[0] + lastTwo[1]);
  }
  return fibs;
};

// console.log(fib(5));

var fibRec = function (count) {
  if (count === 1) {
    return [0];
  }
  if (count === 2) {
    return [0, 1];
  }
  var fibs = fibRec(count - 1);
  var lastTwo = fibs.slice(-2);
  fibs.push(lastTwo[0] + lastTwo[1]);
  return fibs;
};

// console.log(fibRec(5));

var binarySearch = function(array, target) {
  var middle = Math.floor(array.length / 2);
  var subArr;

  if (array.length === 0 ) {
    return null;
  }
  if (array[middle] === target) {
    return middle;
  }

  if (array[middle] > target) {
    subArr = array.slice(0, middle);
    return binarySearch(subArr, target);
  } else {
    subArr = array.slice( middle + 1 );
    var subIndex = binarySearch(subArr, target);
    if (subIndex === null) {
      return null;
    } else {
      return subIndex + middle + 1;
    }
  }
};

// console.log(binarySearch([1, 2, 3, 4, 5, 6], 6));

var makeChange = function(amount, denominations) {
  var bestSolution = null;
  for (var i = 0; i < denominations.length; i++) {
    var coin = denominations[i];
    var remainder = amount - coin;
    if (remainder === 0) {
      return [coin];
    }
    // do nothing if (remainder < 0 )
    if (remainder > 0) {
      var remainderChange = makeChange(remainder, denominations);
      if (remainderChange !== null) {
        var newSolution = [coin].concat( makeChange(remainder, denominations) );
        if (bestSolution === null || bestSolution.length > newSolution.length) {
          bestSolution = newSolution;
        }
      }
    }
  }
  return bestSolution;
};

// console.log(makeChange(14, [10, 7]));

Array.prototype.mergeSort = function() {
  if (this.length < 2) {
    return this;
  }
  debugger;
  var middle = Math.floor(this.length / 2);
  var left = this.slice(0, middle).mergeSort();
  var right = this.slice(middle).mergeSort();

  var sorted = [];

  while (left.length > 0 || right.length > 0) {
    if ( left.length === 0 ) {
      sorted.push(right.shift());
    } else if (right.length === 0 || left[0] < right[0]) {
      sorted.push(left.shift());
    } else {
      sorted.push(right.shift());
    }
  }

  return sorted;
};

// console.log([4,654, 6, 5742, 1].mergeSort());

Array.prototype.subsets = function() {
  if (this.length === 0) {
    return [[]];
  }
  var shortArray = this.slice(1);
  var subs = [];
  subs = shortArray.subsets;
  var subsLength = subs.length;
  for (var i = 0; i < subsLength; i++) {
    var sub = subs[i].push(this[0]);
    subs.concat(sub);
  }
  return subs;
};
