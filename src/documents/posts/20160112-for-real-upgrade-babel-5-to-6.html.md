```
title: FOR REALS Guide to upgrading from Babel 5 => 6
description: FOR REALS Guide to upgrading from Babel 5 => 6
created: 2015/02/16 02:16:20
post_name: git-replay-changes
status: publish
tags: post, development, software, coding, babel, ecmascript, javascript, es5, es6, es2015
layout: post
```

## Because it's changed since October

There have been a bunch of [guides on upgrading to babel 5](https://medium.com/@malyw/how-to-update-babel-5-x-6-x-d828c230ec53#.kfcq7zxhx).

Even those written in the last two months are already out of date. Babel moves annoyingly fast.

Please note: this is up to date as of 6.3.13. As I write this, it might also be obsolete.

### Skip babel-core and babel-loader. User babel-register.

Due to some complaints about the various ways you could bootstrap babel into an app, there is now [babel-register](https://github.com/babel/babel/tree/master/packages/babel-register).

If you've held onto using babel 5 until now, porting over couldn't be easier:

Replace `require('babel/register')` with `require('babel-register')`.

Assuming you've installed the `babel-register` package.

### .babelrc

You'll want to create a `.babelrc` file to store your babel settings. For most folks, the easiest port from 5 => 6 looks like this:

```
{
  "presets": ["es2015"]
}
```

This also assumes you've installed the `babel-preset-es2015` package. This will give you most of the es2015 behavior you had. With caveats.

### Exporting and Destructing Objects? Whoops

Apparently in ES6 [you can't export and then destructure objects](https://medium.com/@kentcdodds/misunderstanding-es6-modules-upgrading-babel-tears-and-a-solution-ad2d5ab93ce0#.6mclbhavc).

Which means if you have any code that looks like this:

```javascript
export default {
  a: 1,
  b: 2,
  c: 3
}
```

with an import like this:

```javascript
import {a,b,c} from './terrible-json-object';
```

you're in a bit of a pickle. You could upgrade your code to ES6 standards, OR you can install `babel-plugin-add-module-exports` in your codebase, and add the plugin to your `.babelrc`:

```
{
  "presets": ["es2015"],
  "plugins": ["add-module-exports"]
}
```

This restores the behavior of Babel 5 in this case, which while not strictly ES6 compliant, will at least allow you to upgrade without having to change a ton of code.

Crisis adverted.

### PLEASE NOTE: Some Babel 5 features are missing from Babel 6

One method I've found missing is `Object.values`.

`Object.values` is an [ES7 stage 3 proposal](http://www.2ality.com/2015/11/stage3-object-entries.html) and is part of Babel 5 but there is no support for this functionality in Babel 6. Yet. Again, this might be out of date as of the writing of this article.

As of today this has not appeared in the official [Stage 3 plugin](http://babeljs.io/docs/plugins/preset-stage-3/) from Babel.



