```
title: Node 4 and Babel 6 in Harmony
description: A note for the upgrade from Node 4 and Babel 6
created: 2016/01/16 01:12:16
post_name: git-replay-changes
status: publish
tags: post, development, software, coding, babel, node, es6, es2015, ecmascript, javascript, es5, es7
layout: post
```

## Pun in title intentional

I upgraded a heap of projects I was working on to node 4.2.3 and [babel 6](/posts/20151231-for-real-upgrade-babel-5-to-6/).

As I did a quick and dirty upgrade, I kept thinking to myself: doesn't node 4/5 have [pretty good support for es6/2015](https://nodejs.org/en/docs/es6/#which-features-ship-with-node-js-by-default-no-runtime-flag-required)?

As I was looking around the internet for  ~~Hello Kitty Formalwear~~  babel 6 upgrade tips, I came across [this package which read my mind](https://github.com/jbach/babel-preset-es2015-node4).

So if you're a node 4/5 user, by doing this:

```
npm install --save-dev babel-preset-es2015-node4
```

Then changing your `.babelrc` to look something like this:

```
{
  "presets": ["es2015-node4"]
}
```

you'll get the minimal tranpilation needed to use the latest ES6 features with node 4/5.



