```
title: Setting up MongoDB to work with Derby.js
link: http://codetype.wordpress.com/2012/09/06/setting-up-mongodb-to-work-with-derby-js/
author: mablair2
description:
post_id: 345
created: 2012/09/06 14:57:57
created_gmt: 2012/09/06 06:57:57
comment_status: open
post_name: setting-up-mongodb-to-work-with-derby-js
status: publish
tags: post, development, software, web, html, JavaScript, CoffeeScript, EMCAScript, C#, .NET
layout: post
```

# Setting up MongoDB to work with Derby.js

This post is going to cover installing and configuring MongoDB to use with Derby. If you're reading this post looking to add model persistence to your Derby application but don't know much about MongoDB, understanding MongoDB will help you understand Derby and the model system it uses.

# What's MongoDB?

From their website:

> MongoDB (from "humongous") is a scalable, high-performance, open source NoSQL database.

If you've never used [MongoDB](http://www.mongodb.org/) before, you should immediately go [here](http://try.mongodb.org/). This is the easiest, fastest way to learn the basics of what mongo is and how it works. And it only takes about fifteen minutes. It's even interactive to keep you from getting bored. Go give it a play.

# Derby and MongoDB

Now that you have an idea about how MongoDB works, many of the conventions Derby uses for models should make sense. If you scan through the [Derby Query Readme](https://github.com/codeparty/racer/blob/master/src/descriptor/query/README.md) now, hopefully is makes a bit more sense (like where the term "gte" came from).

# Installing MongoDB

If you still need to install MongoDB go [here](http://www.mongodb.org/display/DOCS/Quickstart) for downloads and installation directions.

# Configuring Derby to use MongoDB

Now that you know about MongoDB, let's get MongoDB set up to work with [Derby](http://derbyjs.com/). This is straightforward and takes about two minutes. To add MongoDB to your Derby application, you'll need to include the `racer-db-mongo` package in your project. Update your `package.json` file to look something like this:
``` json
 {
    "name": "potluck",
    "description": "",
    "version": "0.0.1",
    "main": "./server.js",
    "dependencies": {
        "derby": "*",
        "derby-ui-boot": "*",
        "express": "3.0.0beta4",
        "gzippo": ">=0.1.7",
        "racer-db-mongo": "*" //this is the line. Glory in its beauty.
    },
    "private": true
}
```

Then, at the command prompt, update your project (and download the recently added `racer-db-mongo` dependency) using the following command:

     npm update

You'll have to update your server configuration (by default in `/lib/server/index.js`) to use the new dependency. This requires TWO new lines of code
``` js
derby.use(require('racer-db-mongo')); // This line is new
app.createStore({ listen: server , db: {type: 'Mongo', uri: 'mongodb://localhost/database'} /* This line is new */ });
```

That's all the changes you need to make to add MongoDB to your project. So why I'd bother with a blog post?

# What About Troubleshooting?

Now, if you go and start your Derby application, you might see the following error:

    Error: failed to connect to [localhost:27017]

Which means:

  1. You've installed the `racer-db-mongo` dependency correctly!
  2. You now need to:
    * Install MongoDB
    * Turn on MongoDB
    * OR Fix MongoDB
If you've forgotten to [install Mongo](http://www.mongodb.org/display/DOCS/Quickstart), if you look around, you'll probably find a link somewhere which will help you out.

# Starting/Stopping/Statusing MongoDB

If you've installed Mongo, you have to start the service before Derby can use it. On Ubuntu, you start Mongo using the following command:

     sudo start mongodb

Remember to stop Mongo later with:

     sudo stop mongodb

If you've started Mongo, then loaded your Derby application, and you're still getting an error, it's possible that Mongo did not start correctly. Typing:

     sudo status mongodb

will let you know if Mongo is running or not. If you've run the Mongo Start command, yet the status command is telling you that Mongo is stopped, the most likely cause is Mongo did not shut down gracefully last time it was run. You'll have to go and repair your installation (luckily, this is pretty easy).

# Repairing MongoDB

To repair your installation, run the following commands:

    $ sudo rm /var/lib/mongodb/mongod.lock
    $ sudo -u mongodb mongod -f /etc/mongodb.conf --repair

_The code above was taken from [this](http://blog.brianbuikema.com/2011/01/mongodb-ubunto-overview-installation-setup-dev-python-2/) great article_ At this point, you should have a working copy on MongoDB along with a working integration with Derby. Congrats!

# MongoDB is working great - now Derby hates me

If your application loads, but you're getting a strange error whenever you add to a collection that looks something like this:

    Error: No persistence handler for
    push(FIRST_WORD.SECOND_WORD, [object Object], 18)

It means that you are pushing to the wrong portion on an model path. You can only use push to arrays, and arrays are not objects, and you can only use objects for the first and second words of your model path. In the case shown above, a push is attempting to be made to

     FIRST_WORD.SECOND_WORD

which equates to

     FIRST_WORD.SECOND_WORD.push(object)

which means SECOND_WORD is an array (which isn't allowed). If this last bit of explanation might have well been in Latin, check out [this post](/posts/20120722-derby-js-playing-with-models). It'll explain a little bit about how to declare models and what Derby is expecting you to do. Unfortunately, you CAN use the second word of a model path as an array without persistence support. So this kind of bug will only surface once you've got MongoDB integrated with Derby.
