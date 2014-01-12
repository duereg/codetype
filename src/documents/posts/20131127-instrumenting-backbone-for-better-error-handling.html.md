```
title: A/B Testing and Random Selection everywhere!
description: A/B Testing or Random Selection in the browser and on the server
created: 2013/11/27 06:03:09
post_name: instrumenting-backbone-for-better-error-handling
status: publish
layout: post
```

#Instrumenting Backbone for better error handling

At work we've been having some issues tracking down some nasty client side bugs. We know they're happening in our Backbone views, but we've been unable to locate them with any accuracy due to the errors bubbling all the way to the window.onerror handler.

Enter Stackbone. A simple bit of code to instrument Backbone’s event loops to better locate client side errors.

To use:

``` js
Stackbone.start({
  Backbone: Backbone
  jQuery: jQuery
  onError: function (err) {
    // ... log the error ...
  }
});
```

You can either `Stackbone = require(‘stackbone’)` or simply include the .js file in a script tag.

Enjoy!