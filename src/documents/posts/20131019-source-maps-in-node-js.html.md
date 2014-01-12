```
title: Source maps in node.js
description: Source maps in node.js
created: 2013/10/19 19:33:27
post_name: source-maps-and-immature-tooling
status: publish
layout: post
```

# Source maps in node.js

One of the projects I'm working on deals with source maps.

If you don't know anything about source maps [this link](http://www.html5rocks.com/en/tutorials/developertools/sourcemaps/) is a good introduction to what source maps are and why they're useful.

Looking at the article date (March 21st, 2012), it's not like source maps are some new hot thing. But the tooling around them is still pretty raw as is their use.

So why would you want to use source maps?

 * Source maps are great for client side development. You can minify/mangle your code, use it in dev, and still debug. Faster dev environments while still being able to debug.
 * Source maps can give you decent stack traces in your production environment without hurting your site's performance. And without exposing any of your unminified source code to the end user.

Read that last point again. This is the killer feature we were looking for at work - being able to track down client side errors reliably on production.

To do this you have to jump through a few hoops. At least in a node.js environment.

## The three ways to use source maps

There are three ways you can include source maps in your project.

 1. You can imbed the source map directly in a .js file.
 2. You can add a comment to the .js to that points to the appropraite source map.
 3. You can set a header in the response for the .js file that points the browser to a source map.

If you use [Browserify](http://browserify.org/) you can turn on option 1 just by setting `debug: true` in your configuration. You'll probably notice the performance degradation almost immediately. That's because browserify includes your source map (with includes all your source) along with the combined .js you're given it. Which is a pretty huge payload compared to just .js.

## Making source maps work in development

If you strip out that source map from the .js file and move the code to an external .map file you still have the ability to debug your browserify-ied code without hurting your performance.

Browsers only download external source maps (source maps included via option 2 or 3) when they are needed. So even in development your app will load quickly if you have *external* source maps. Once you open your debugger in the browser then you'll go and download the source maps you need to debug the current page.

## Making source maps work in production

However, the source maps you generate for development aren't appropriate for production. Why? Two reasons.

 1. All of your source code is available for download from the source map.
 2. The .js browserify generates in `debug` mode is unminified.

Even if you want to use source maps in production you wouldn't want to push unminified code up. You also don't want to expose your source code to the public. Luckily there is a solution: [UglifyJS](https://github.com/mishoo/UglifyJS2).

So Uglify (or more correctly Uglify 2) can take your unminified code and minify for you. If given a source map as input it can rewrite the source map to now point at the minified file. Pretty good.

That would still leave us with the problem with the embedded source code in your source map. Except for one thing - they're a bug in Uglify. It strips out the embedded source code when it does it second run on your source map to get it match to the newly minified code.

Which means an uglified, external source map can be pushed to production. You won't be able to debug production - you won't have any source to look at - but an error that occurs will at least give you a decent stack trace.