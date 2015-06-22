var string = "0,0,0,0";
// console.log(string.split(',').map(function (el) { return parseInt(el); } ));
console.log(string.split(',').map(parseInt.bind(this)));
// console.log(string.split(',').map(parseInt));
