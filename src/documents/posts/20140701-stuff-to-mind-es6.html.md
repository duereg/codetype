```
title: Stuff to mind when writing ES6 code
description: Stuff to mind when writing ES6 code
created: 2014/07/01 01:05:19
post_name: stuff-to-mind-es6
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, Ember, Ember.js, Ember.data, ES6
layout: post
```

These are some good tips I picked up browsing the ember and ember.data commits. Nice if you're looking for best practices in writing ES6 code.

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

Some other interesting tidbits (not sure of the validity of all of these, but this is what some of the Ember guys claim):

* re-using argument variables makes it quite hard to see the original value
* re-using argument variables has some negative performance side-effects.
* using the comma operator for long variable declarations makes it impossible to easily set breakpoints.
