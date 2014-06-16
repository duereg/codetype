```
title: Derby.js - Playing with Models
link: http://codetype.wordpress.com/2012/07/22/derby-js-playing-with-models/
author: mablair2
description:
post_id: 136
created: 2012/07/22 14:29:18
created_gmt: 2012/07/22 06:29:18
comment_status: open
post_name: derby-js-playing-with-models
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, node, express, node.js, express.js, async, derby, real-time, sockets
layout: post
```

# Derby.js - Playing with Models

Been playing around with [Derby](http://derbyjs.com) in my spare time. The idea behind the platform is smart - using node and express, you write one set of code, and that code automatically syncs data between browsers, servers, and a database.

Derby is still raw. The documentation is comprehensive but puts important information about the same topic in different places.

I've culled the following eight lines of documentation of defining models from the documents:

> **Racer Paths** Racer paths are translated into database collections and documents using a natural mapping: `collection.documentId.document` All synced paths (anything that doesn’t start with an underscore) must follow this convention. In other words, all model data stored at the first two path segments should be an object and not a string, number, or other primitive type.

> ** Private paths** Paths that contain a segment starting with an underscore (e.g. _showFooter or flowers.10._hovered) have a special meaning. These paths are considered “private,” and they are not synced back to the server or to other clients. Private paths are frequently used with references and for rendering purposes.

Now, this information is useful if you're trying out the model system for the first time. The most important line (at least for my initial playing around), was this one:

**In other words, all model data stored at the first two path segments should be an object and not a string, number, or other primitive type.**

What this means: if, in creating your first model, you trying something like this: `model.set('people', []);` Eventually you will get an error. However, `model.set('myApp.containers.people', []);` will work just fine.

_**A follow up to this post is [here](/posts/20120807-derby-js-working-with-view-templates-models-and-bindings).**_
