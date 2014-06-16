```
title: React, server side rendering, and a cool data embedding technique
description: Novel way to embed data in an HTML page
created: 2014/01/16 00:13:34
post_name: react-server-side-rendering
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, EMCAScript, React
layout: post
```

# React, server side rendering, and a cool data embedding technique

I've been spending some time going through the [React](http://facebook.github.io/react/) docs and examples for some work on a side project.

What is React? From their website:

> React: A javascript library for building user interfaces

The React devs have some killer ideas about how to render web pages using something they call a Virtual DOM. Also from React's website:

> React uses a virtual DOM diff implementation for ultra-high performance. It can also render on the server using Node.js — no heavy browser DOM required.

Some people who've been experimenting with React has shown dramatic client-side rendering performance improvements - [2-4x faster in the average case, up to 30-40x in certain cases](http://swannodette.github.io/2013/12/17/the-future-of-javascript-mvcs/).

The Virtual DOM implementation would be enough for most people to switch over to trying out React, but I think the killer feature of React isn't the blazing client-side performance - it's the ability to server-side render.

It's well known that [server-side rendering can reduce page load times](https://blog.twitter.com/2012/improving-performance-twittercom). Twitter claimed to reduce page loads times to 1/5th of what they had been by server side rendering.

So:

`1/5th * (2x as fast) == Really, Really Fast Rendering`

(Especially in low-power devices like phones)

So how do you server side render with React?

The client makes a request for a page.

On the server, you:

 1. You grab whatever data is appropriate for the request
 2. You pass that data into some React components, generating HTML
 3. You embed the data in a page to send to the client
 4. You embed the generated HTML in a page to send to the client
 5. You add a script block to include all the needed JS in the page to glue to all together
 6. You send the client back the html with the data / generated HTML / react JS code.

There is a good example of this flow [here](https://npmjs.org/package/react-server-example).

My favorite part of this example - and a cool way to embed some code - are these lines of code:

``` js

  // Include our static React-rendered HTML in our content div.
  // This is the same div that we render the component to on the client side,
  // and by using the same initial data, we can ensure that the contents are the same
  // (React is smart enough to ensure no rendering will actually occur on page load)
 '<div id=content>' + myAppHtml + '</div>' +

  // Ensure that our initial data is also accessible on the client-side by embedding it
  // here in the page.
  // We could have used a window-level variable, or even a JSON-typed script tag,
  // but this option is safe from namespacing and injection issues,
  // and doesn't require parsing
  '<script type=text/javascript>' +
    'document.getElementById("content").myAppProps = ' + escapeJs(JSON.stringify(props)) +
  '</script>' +
```

That embedding code - adding data to a DOM element for a particular component - is a pretty cool way to get the data you need client-side.
