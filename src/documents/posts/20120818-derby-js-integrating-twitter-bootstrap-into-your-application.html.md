```
title: Derby.js - Integrating Twitter Bootstrap into your Application
link: http://codetype.wordpress.com/2012/08/18/derby-js-integrating-twitter-bootstrap-into-your-application/
author: mablair2
description:
post_id: 236
created: 2012/08/18 13:07:52
created_gmt: 2012/08/18 05:07:52
comment_status: open
post_name: derby-js-integrating-twitter-bootstrap-into-your-application
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, C#, .NET
layout: post
```

# Derby.js - Integrating Twitter Bootstrap into your Application

As I've mentioned in a [previous post](/posts/20120504-why-use-twitter-bootstrap), I'm a big fan of Twitter Bootstrap. Lately I've been playing been with JavaScript and [Derby](http://www.derbyjs.com). I want to integrate bootstrap with the POC site I'm building, and the creators of Derby have already figured out a way to do this.

Step 1: Add a dependency to the [derby-ui-boot](https://github.com/codeparty/derby-ui-boot/) package, which is a Derby component library based on Twitter Bootstrap.
``` json
 { .... "dependencies": { "derby": "*", "derby-ui-boot": "*", "express": "3.0.0beta4", "gzippo": ">=0.1.7" }, .... }
```

 Step 2: Update your project with the downloaded ui-boot code This is as simple as running `npm update` in your project folder, which will read package.json, and download any missing dependencies (like the derby-ui-boot entry you just added).

 Step 3: Add the derby-ui-boot component to your project. At the top of your application JavaScript (for me, this is the file located at /lib/app/index.js), after your `var derby = require("derby");` line, add the following line of code to your file:

``` js
 var derby = require("derby"); derby.use(require('derby-ui-boot'));
```

 Step 4: Profit! That should be it for you. When you load your application up, the default twitter bootstrap css and js should have loaded. To correctly style your application, you'll have to follow the guidelines laid out [here](http://twitter.github.com/bootstrap/scaffolding.html) and [here](http://twitter.github.com/bootstrap/base-css.html).
