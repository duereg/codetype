```
title: Post about Songbird on npmawesome
description: Post about Songbird on npmawesome
created: 2014/06/26 19:48:09
post_name: post-about-songbird-on-npmawesome
status: publish
tags: post, development, software, coding, web, html, JavaScript, CoffeeScript, EMCAScript, npmawesome, songbird, promises, prototype, bluebird
layout: post
```

The folks at [npmawesome](npmawesome.com) wrote a blog post about the [Songbird](https://github.com/duereg/songbird)  library I wrote.

Songbird is a library that mixes in promise helpers in the Function and Object prototypes on JavaScript. This is a technique that not everybody loves, and I think the author made a great observation about Songbird (and this technique in general).

> While I think it's a great idea to mix in the promise property to Object and Function, however with great power comes great responsibility. I strongly urge against using songbird in modules that you would distribute on npm because it would have a very big side effect on anyone who dares to install your code. However, when used on a project that isn't made available publicly, songbird would be a great asset.

Check out the blog post [here](http://npmawesome.com/posts/2014-06-26-songbird/).
