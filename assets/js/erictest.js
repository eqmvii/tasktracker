console.log("Now we're JavaScripting!");
console.log(this);

var dinosaur = {
    roar: function() { console.log("ROAAAR!"); },
    stomp: function() { console.log ("stomp stomp stomp!"); }
}

dinosaur.roar();

// console.log('Tasty Brunch, just trying to use jQuery!', $('body'));

var $ = require('jquery');
console.log('Tasty Brunch, just trying to use jQuery!', $('body'));