```
title: Introducing Songbird
description: How to have promises everywhere, all the time
created: 2014/02/09 13:34:01
post_name: introducing-songbird
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, EMCAScript, Songbird, Bluebird, Promises, Generators, EMCAScript
layout: post
```

# Introducing Songbird

Would you rather write this:

```javascript
var updateUser = function(id, attributes, callback) {
  User.findOne(id, function (err, user) {
    if (err) return callback(err);

    user.set(attributes);
    user.save(function(err, updated) {
      if (err) return callback(err);

      console.log("Updated", updated);
      callback(null, updated);
    });
  });
});
```

Or this:

```coffeescript
  User.promise.findOne(id).then( (user) →
    user.set(attributes)
    user.promise.save()
  ).then (user) -> console.log("Updated", user)
```

[Songbird](http://www.github.com/duereg/songbird) allows you to easily mix asynchronous and synchronous programming styles in node.js.

I based Songbird on the [bluebird promise library](https://raw2.github.com/petkaantonov/bluebird/master/API.md) (hence the name).

Install
-------

Songbird requires node version 0.6.x or greater.

```
npm install songbird
```

Examples
-----


### Without Songbird

Using standard node callback-style APIs without Songbird, we write
(from [the fs docs](http://nodejs.org/docs/v0.6.14/api/fs.html#fs_fs_readfile_filename_encoding_callback)):

```javascript
fs.readFile('/etc/passwd', function (err, data) {
  if (err) throw err;
  console.log(data);
});
```

### Using the promise property

Using Songbird, we write:

```javascript
fs.promise.readFile('/etc/passwd').then(console.log);
```

### Object & Function mixins

Songbird mixes `promise` into `Function.prototype` so you can
use them directly as in:

```javascript
readFile = require('fs').readFile;
readFile.promise('/etc/passwd').then(console.log);
```

Songbird adds `promise` to `Object.prototype` correctly so they
are not enumerable.

These proxy methods also ignore all getters, even those that may
return functions. If you need to call a getter with Songbird that returns an
asynchronous function, you can do:

```javascript
func = obj.getter
func.promise.call(obj, args)
```

### Handling Multiple Promises

Requiring the songbird library updates the Object and Function prototype and returns a Promise library. This library allows you to carry out certain actions that are hard to handle from the promise property.

For example: You're dealing with multiple promises but don't care what order they complete in.

```js
Promise = require("songbird");

Promise.all([task1, task2, task3]).spread(function(result1, result2, result3){

});
```

Normally when using `.then` the code would look like:

```js
Promise = require("songbird");

Promise.all([task1, task2, task3]).then(function(results){
    var result1 = results[0];
    var result2 = results[1];
    var result3 = results[2];
});
```

For more information about the underlying bluebird promise API, the [API docs are here](https://raw2.github.com/petkaantonov/bluebird/master/API.md).

### Disclaimer

Some people don't like libraries that mix in to Object.prototype
and Function.prototype. If that's how you feel, then Songbird is not for you.

Contributing
------------

```
git clone git://github.com/duereg/songbird.git
npm install
npm test
```

Songbird is written in [CoffeeScript](http://coffeescript.org) with
source in `src/` compiled to `lib/`.

Tests are written with mocha and chai in `test/`.

Run tests with `npm test` which will also compile the CoffeeScript to
`lib/`.

Pull requests are welcome. Please provide tests for your changes and
features. Thanks!
