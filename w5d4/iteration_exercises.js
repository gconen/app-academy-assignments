Array.prototype.bubbleSort = function () {
  var unsorted = true;
  while (unsorted) {
    unsorted = false;
    for ( var i = 0; i < this.length - 1; i++ ) {
      if ( this[i] > this[i+1] ) {
        var placeholder = this[i];
        this[i] = this[i+1];
        this[i+1] = placeholder;
        unsorted = true;
      }
    }
  }

  return this;
};

// console.log([234, 2, 4, 232, 2431, 56].bubbleSort());
String.prototype.substrings = function () {
  var substrings = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j <= this.length; j++) {
      var sub = this.slice(i,j);
      if (substrings.indexOf(sub) === -1 ) {
        substrings.push(sub);
      }
    }
  }
  return substrings;
};

console.log("cat".substrings());
