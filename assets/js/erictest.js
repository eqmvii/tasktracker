var $ = require('jquery');


console.log("Now we're JavaScripting!");
console.log(this);

var dinosaur = {
    roar: function () { console.log("ROAAAR!"); },
    stomp: function () { console.log("stomp stomp stomp!"); }
}

dinosaur.roar();

// console.log('Tasty Brunch, just trying to use jQuery!', $('body'));

console.log('Tasty Brunch, just trying to use jQuery!', $('body'));

// pulling from a phoenix/elixir test JSON API that looks like:
// def blob(conn, _params) do
//      json conn, %{name: "Eric 'from a JSON route' Mancini", JSON: true, test_list: [1, "a", 3]}
// end
$.ajax({
    url: "/api/" // lol does this get the rendered error page if it errors? Funny... that... probably isn't right...
}).done(function (data) {
    console.log(data);
    if (data.JSON) {
        console.log(`My name is ${data.name}!`);
    }
});

$.ajax({
    url: "/api/todos"
}).done(function (data) {
    console.log(data);
    console.log(`I am logged in as ${data.logged_in_as}!`);
});