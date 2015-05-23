function Clock () {
};

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.hours.toString() + ":" +
      this.minutes.toString() + ":" + this.seconds.toString());
};

Clock.prototype.run = function () {
  this.date = new Date();
  this.seconds = this.date.getSeconds();
  this.minutes = this.date.getMinutes();
  this.hours = this.date.getHours();
  this.printTime();
  setTimeout(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  this.seconds += Clock.TICK / 1000;
  if (this.seconds >= 60) {
    this.minutes += 1;
    this.seconds -= 60;
    if (this.minutes === 60) {
      this.hours += 1;
      this.minutes = 0;
      if (this.hours === 24 ) {
        this.hours = 0;
      }
    }
  }


  this.printTime();
  setTimeout(this._tick.bind(this), Clock.TICK);
};

var clock = new Clock();
//clock.run();

var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function (sum, numsLeft, completionCallback) {
  if (numsLeft === 0){
    completionCallback(sum);
    reader.close();
  } else {
    reader.question("Enter a number: ", function (input){
      sum += parseInt(input);
      console.log(sum);
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  }
};

//addNumbers(0,3,console.log);

var absurdBubbleSort = function (arr, sortCompletionCallback) {

  var outerBubbleSortLoop = function (madeAnySwaps) {
    if (madeAnySwaps) {
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  };

  outerBubbleSortLoop(true);
};

var askIfGreaterThan = function (el1, el2, callback) {
  reader.question("Is " + el1 + " greater than " + el2 + "? ", function(input) {
    if (input === "yes"){
      callback(true);
    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i >= arr.length - 1) {
    outerBubbleSortLoop(madeAnySwaps);
  } else {
    askIfGreaterThan(arr[i], arr[i+1], function(result) {
      if (result) {
        var tmp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = tmp;
        madeAnySwaps = true;
      }
        innerBubbleSortLoop(arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
};


absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});







//
