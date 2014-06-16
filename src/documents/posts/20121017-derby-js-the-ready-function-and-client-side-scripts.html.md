```
title: Derby.js - The Ready() Function, and Adding Client-Side Scripts to your App
link: http://codetype.wordpress.com/2012/10/17/derby-js-the-ready-function-and-client-side-scripts/
author: mablair2
description:
post_id: 450
created: 2012/10/17 20:48:14
created_gmt: 2012/10/17 12:48:14
comment_status: open
post_name: derby-js-the-ready-function-and-client-side-scripts
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, EMCAScript, C#, .NET
layout: post
```

# Derby.js - The Ready() Function, and Adding Client-Side Scripts to your App

I've found a neat feature of [derby](http://derbyjs.com) dealing with the ready() function. I've been creating a derby app, and in my application I need to load up a client-side calendar. With a standard HTML web page this is straightforward thing to do. On the page you wanted the calendar, you would include the client js for the calendar, some code to load it, and that would be that. Derby introduced some complexity to this relatively simple task. On my first attempt, I put my scripts in the section of the page that I needed the calendar on. I added a script to load the calendar as well. When I went to the url of the page, it loaded immediately. Success! (I thought).

Then I clicked a link away from my calendar, and then clicked back. No calendar. What happened? When I loaded the link originally, the page was rendered from the server. The second time, the page was rendered client side. Something wasn't working with loading the calendar on the client-side render. You need a place to put your code that guarantees that it will load on the client-side. The `app.ready()` function is designed to handle this scenario. What is the purpose of the `app.ready()` function? From the derby documentation:

> Code that responds to user events and model events should be placed within the app.ready() callback. This provides the model object for the client and makes sure that the code is only executed on the client. **This function is called as soon as the Derby app is loaded on the client.** Note that any code within this callback is only executed on the client and not on the server.

I've bolded the part I think is particularly important. This code is run as soon as the client is loaded. Which means if you have more than a single-page app, using `app.ready()` to load a feature might not work out. So what to do? An undocumented feature of Derby - app.on(). What does it do? It allows you to load code AFTER a specific page has loaded. Which is exactly what I'm looking for. So here's what I ended up writing in my `app.ready()`:

``` js
app.on('render:calendar', function(ctx) {
  logger.log("rendering calendar client-side...");
  new Timeline("timeline", new Date());
});
```

 In this example this code will run after rendering the `calendar` view. On the Calendar page, there is a script block which loads the `Timeline` function. After writing this code, I tried my page again. Still no luck. I wasn't getting the calendar to load on both the client and server load. On a lark, I moved the block containing my Timeline javascript to my index view, and tried again. Success. Which makes sense. If you are rendering pages via the client side load, additional resources aren't going to be loaded. So by putting my script into the index view, it's unfortunately loaded for all my pages, but at least it's available for both the client and server side rendering of my cool control.
