```
title: Some node.js and express.js beginner help
link: http://codetype.wordpress.com/2012/07/10/some-node-js-and-express-js-beginner-help/
author: mablair2
description:
post_id: 103
created: 2012/07/10 16:27:32
created_gmt: 2012/07/10 08:27:32
comment_status: open
post_name: some-node-js-and-express-js-beginner-help
status: publish
layout: post
```

# Some node.js and express.js beginner help

I've just started using [node.js](http://nodejs.org/) with [express.js](http://expressjs.com) on both Windows (with iisnode) and Ubuntu.

I love the stack (one programming language from front to back!), but some of the documentation has been frustrating for me. I wanted to document what I've learned so far in the hopes that it'll help someone else down the line.

## Generate the starter app

At first, I wanted to just hack away some of the existing example apps that were out there.

This ended up being a pretty frustrating experience as most of the basic examples were just sending 'Hello World' back to the browser. I didn't want to do much more than that when I was starting out, but I did at least want to load a basic page with some basic information I passed in.

After hours of browsing blogs and the express documentation, I managed what I wanted. Right after I did this from scratch, I found out that express can generate the basic application I wanted.

**From the express.js documentation: **
The quickest way to get started with express is to utilize the executable express(1) to generate an application as shown below:

### Create the app:

` $ npm install -g express $ express /tmp/foo && cd /tmp/foo `

### Install dependencies:

` $ npm install -d `

### Start the server:

` $ node app.js ` But what does "generate an app" mean? When I first read those lines, I skipped right past this step, as I though I already had express and its dependencies setup correctly.

These commands create the basic structure of a web app (with all the basic files, folders, and dependencies installed).

Let's walk the commands to get a better idea what each of them does

## The installation commands, explained

`npm install -g express `
[NPM](http://npmjs.org), or the Node Package Manager, is a tool that comes with node that allows your install node packages quickly and easily from the command line. This command installs express, the popular MVC-ish framework for node.

`express /tmp/foo && cd /tmp/foo`
This line of code installs express into /tmp/foo, then changes the directory to /tmp/foo. You can also run this command from the folder you want to install express in (just run express from the command line). You can also specify some options when you generate your starter app, such as the templating and stylesheet language you want to use.

`express -t jade -c stylus`
This command tells express you want to install in the current directory, using [Jade](http://jade-lang.com/) as your template language, and [Stylus](http://learnboost.github.com/stylus/) as your stylesheet language.

`npm install -d `
This command installs any dependencies that express needs for the instance you have installed. Express has a couple js packages that it needs to run, so this command goes and downloads the latest version of these dependencies.

## What "Generate An App" Gives You

  * node_modules

This folder contains all the js dependencies (like express, stylus, jade, etc) that you need to run express on node.

  * public

This is where your static files go (by default). By default, this folder contains three sub-folders:
    1. images
    2. javascripts
    3. stylesheets

  * routes

This is where your routing logic goes. Initially this contains one route (to your example view).

  * views

This folder is the default location for the views you'll use in your application. Views usually contain dynamic content and are often written in a templating language.

The last thing that's generated is app.js, which contains a good sample of configuration code as well as the only route your example route contains:

`var express = require('express') , routes = require('./routes'); ... app.get('/', routes.index); `

If you jump into the routes folder, and open index.js, you'll see your index route:

` exports.index = function(req, res) { res.render('index', { title: 'Express' }) }; `

But what does this code mean? The first line of code defines two variables, `express and routes`.

The first is a registered node module, express, and the second is just a js file.

Later in ` app.js `, the line ` app.get ` tells node that when the base Url of your application (something like http://localhost:3123/) is called in a browser, that the routes.index method should be called.

But how does routes variable in the first file get the index method, when in ` index.js ` in the routes folder only defines the ` index ` function on something calls `exports`?

To keep the system loosely coupled, node uses something called the [CommonJS module format](http://wiki.commonjs.org/wiki/Modules/1.1) to inject dependencies into an application. One way to do this is create a function you want to be able to export to the rest of your application, then simply add your function to the ` exports ` object in your code. When you call ` require(PATH_TO_YOUR_FILE) `, any methods you added to `exports` will be added to the object returned by your call to `require`.

The final code is the call to `res.render`. This is a call to `express`, which is telling express to load the file 'index.jade' (because in this instance, jade is the default render engine). The second parameter is a JavaScript object containing one element, `title`. This object is passed to the index.jade template to be rendered.