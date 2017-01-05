```
title: Performance Improvement via node 4 to node 6
description: Performance improvement via babel tranpilation removal
created: 2016/11/09 11:10:09
post_name: performance-improvement-via-babel-tranpilation-removal
status: publish
tags: post, development, performance, node, babel, es6, es2015, ecmascript, javascript, es5, es7
layout: post
```

My team at work recently upgraded our codebase to use to node 6.9, as node 6 has recently gone to LTS.

In the picture below, the 1st line is the upgrade from node 4 to node 6, and the corresponding flattening of memory usage vs. load.

The 2nd line is our removal of redis connection queueing in the application.

All of all, the memory consumption of our application is now averaging around 150MB, down from a high of 1GB!

Hope this information helps all those teams considering upgrading their node projects.

![Memory usage graph showing decreasing memory usage](/images/posts/memory-graph.png)
