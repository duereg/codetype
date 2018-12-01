```
title: Moment.js instantiation slowness
description: Moment.js instantiation slowness
created: 2017/05/04 18:14:15
post_name: moment-js-instantiation-slowness
status: publish
tags: post, development, performance, node, moment, slowness, instantiation
layout: post
```

Was doing some test speedup/performance improvement work recently on the search API and found out something; the moment.js library takes around 100 microseconds (or .1 milliseconds) to create a new instance.

Why is 100 microseconds a big deal?

If you're processing:
 - 100 records
 - Where each record has 7 date fields
 - Then you've created 70,000 microseconds of work
 - Or 70 milliseconds of processing delay.

By doing some memoization of date formatting in our API, we've seen these performance improvements:

### Response Times

|       |Before | After |
|-------|-------|-------|
|Fastest|211ms  |194ms  |
|Max    |651ms  |597ms  |
|Average|309ms  |268ms  |


Without making any significant changes, we've managed to shave 41ms off of our response time on average!

Hope this helps someone else.
