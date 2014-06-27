```
title: Stuff to mind when writing code in ES6
description: Stuff to mind when writing code in ES6
created: 2014/07/01 01:05:19
post_name: stuff-to-mind-es6
status: draft
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, ES6
layout: post
```

example: diverging bindings

this is an issue when dealing with cycles.

bad: (diverges bindings)

```javascript
import { foo } from 'bar';

var otherFoo = foo;
foo: (if the rename is actually needed)
```
good:

```javascript
import { foo as otherFoo } from 'bar';
```

example: closure compiler dead code remove friendly:

bad: closure compile wont drop, bar if foo is used, or foo if bar is used

```javascript
export default {
  foo: function() { },
  bar: function() { }
}
```

good: closure compile will drop whats not used correctly.

```javascript
export function foo() { }
export function bar() { }
```

re-using argument variables makes it quite hard to see the original value, also it has some negative performance side-effects.

using the comma operator for long variable declarations, especially if they include method invocations makes it impossible to easily set breakpoints.
