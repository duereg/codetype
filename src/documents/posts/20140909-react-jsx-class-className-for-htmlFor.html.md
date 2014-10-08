```
title: React and the annoyances of JSX
description: React and JSX. class vs className, for vs htmlFor
created: 2014/09/09 15:26:00
post_name: react-jsx-class-className-for-htmlFor
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, React, JSX, class, className, for, htmlFor
layout: post
```

I've been writing a bunch of [React](http://facebook.github.io/react/) code and a heap of [JSX](http://facebook.github.io/react/docs/jsx-in-depth.html) at work.

React (coupled with [Flux](http://facebook.github.io/flux/docs/overview.html)) has been a joy to work with. The uni-directional data flow makes understanding the state of your application at any point easy to understand. The gradual componentization of our UI codebase is a beautiful thing to witness. That, coupled with a component based CSS system (using [BEM](https://bem.info/method/) guidelines for naming classes) has removed the messy bleed over we were having with some of our old css code.

One thing that has consistently annoyed my team has been JSX. Basically, we wish we had something like handlebars that React could use on top of its virtual DOM.

(And yes, we know about [Ractive.js](http://www.ractivejs.org/). If there was better community support for it, we'd probably be using it).

What is annoying us?

1) You can write template code ANYWHERE.

We found some places where we had five different methods in one component that contained JSX. Maybe that's just development, but because JSX is just JavaScript, and you can use JavaScript in your JSX, the reverse is also true. You can hide markup anywhere in your components you feel like it.

2) It's just close enough to HTML to annoy you.

This should be a minor annoyance. But when you're copying between HTML and React on a massive rewrite of a legacy system, it becomes painful.

How is this a problem? I take the markup for an existing component. I copy the markup into React, convert over some fields, get everything working, and then I open up my browser console to get waylaid with tons of React warnings. About what? About my using "for" or "class" attributes in my markup.

These are valid HTML attributes, but in React, you have to use "htmlFor" and "className" respectively.

Why? Because Facebook [hates you and decides against logical arguments](https://github.com/facebook/react/pull/269).

Apparently at some point, you could at least use "class" in your JSX. But at some point the executive decision was made that because JSX is JavaScript, you shouldn't be able to use reserved words in JSX (like "class" and "for"). Even though JSX gets interpolated into JavaScript. And it's got angle brackets. And it almost identically resembles HTML.
