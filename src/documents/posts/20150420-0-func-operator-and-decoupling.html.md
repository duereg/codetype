```
title: The (0, func) operation in transpiled code
description: Figuring out JS quirks
created: 2015/04/20 01:23:50
post_name: 0-func-operator-or-decoupled-function-state
status: publish
tags: post, development, software, coding, javascript, function, decoupling, state, this, global, decompiled
layout: post
```

Was looking at some decompiled code from ES6 the other day, when I saw a line that looked like this:

```
var x = (0, anObject.aFunc)(params);
```

WTF? I had never seen syntax like this before in JavaScript. Time to dig into the docs.

Paraphrasing from Mozilla and StackOverflow:

> When you write expressions separated by a comma (,) JavaScript evaluates all the expressions in order and returns the value of the last expression.

Meaning the expression `(x=1, y=2, anObject.aFunc)` would set the variables `x` and `y`, and return `anObject.aFunc` to the caller.

Now that we know what is going on, why?

Here is the explanation I cobbled together from the Interwebs:

> When you call `anObject.aFunc()`, `this` is equal to `anObject` because `aFunc` is coupled to `anObject`.
>
> When you call `(0, anObject.aFunc)()`, you have decoupled `aFunc` from `anObject`, so `this` is no longer equal to `anObject` in `aFunc`.
>
> In this case, `this` would be equal to the global object - `window` in the browser, or `global` in node.

So in the example given above:

```
var x = (0, anObject.aFunc)(params);
```

Code that would have the same output (in the browser):

```
var x = anObject.aFunc.call(window, params);
```

Or, even more trivially:

```
var boundToWindow = anObject.aFunc;
var x = boundToWindow(params);
```








